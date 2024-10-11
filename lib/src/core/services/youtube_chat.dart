import 'dart:async';
import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:irllink/src/core/utils/globals.dart' as globals;
import 'package:irllink/src/domain/entities/chat/chat_message.dart';

class YoutubeChat {
  String videoId;

  final StreamController<ChatMessage> _chatStreamController =
      StreamController<ChatMessage>.broadcast();
  Stream<ChatMessage> get chatStream => _chatStreamController.stream;

  YoutubeChat(
    this.videoId,
  );

  void closeStream() {
    _chatStreamController.close();
  }

  // Function to fetch the initial continuation token
  Future<String?> fetchInitialContinuationToken() async {
    var headers = {
      'accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
      'accept-language': 'en-US,en;q=0.9',
      'cache-control': 'no-cache',
      'pragma': 'no-cache',
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36'
    };

    String url = 'https://www.youtube.com/live_chat?is_popout=1&v=$videoId';
    try {
      Response response = await http.get(Uri.parse(url), headers: headers);
      Document document = parser.parse(response.body);
      List<Element> scripts = document.getElementsByTagName('script');
      Element ytInitialDataScript = scripts
          .firstWhere((script) => script.innerHtml.contains('ytInitialData'));
      String scriptContent = ytInitialDataScript.innerHtml;
      // Extracting ytInitialData JSON from the script tag
      int dataStart = scriptContent.indexOf('{');
      int dataEnd = scriptContent.lastIndexOf('}') + 1;
      String jsonString = scriptContent.substring(dataStart, dataEnd);
      dynamic ytInitialData = json.decode(jsonString);

      // Extract continuation token from ytInitialData
      dynamic continuation = ytInitialData['contents']['liveChatRenderer']
          ['continuations'][0]['invalidationContinuationData']['continuation'];
      return continuation;
    } catch (error) {
      globals.talker
          ?.error('Error fetching initial continuation token: $error');
      return null;
    }
  }

  Future<String?> fetchChatMessages(String? continuationToken) async {
    String body = json.encode({
      'context': {
        'client': {
          'hl': 'en',
          'gl': 'JP',
          'remoteHost': '123.123.123.123',
          'userAgent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
          'clientName': 'WEB',
          'clientVersion': '2.20240411.09.00',
        },
        'user': {'lockedSafetyMode': false}
      },
      'continuation': continuationToken
    });

    Map<String, Map<String, String>> options = {
      'headers': {'Content-Type': 'application/json'},
    };

    const url =
        'https://www.youtube.com/youtubei/v1/live_chat/get_live_chat?prettyPrint=false';

    try {
      Response response = await http.post(Uri.parse(url),
          headers: options['headers'], body: body);
      dynamic data = json.decode(response.body);

      Iterable<dynamic>? messagesData = (data['continuationContents']
              ['liveChatContinuation']['actions'] as List?)
          ?.map((action) => (action['addChatItemAction']['item']
              ['liveChatTextMessageRenderer']));

      messagesData?.forEach((message) {
        if (message['message'] == null) return;
        List? messages = (message['message']['runs'] as List?)
            ?.map((run) => run['text'])
            .where((message) => message != null)
            .toList();
        if (messages == null) return;
        if (messages.isEmpty) return;
        ChatMessage msg = ChatMessage.fromYoutube(message, messages, videoId);
        _chatStreamController.add(msg);
      });

      dynamic newContinuationToken = data['continuationContents']
              ['liveChatContinuation']['continuations'][0]
          ['invalidationContinuationData']['continuation'];
      if (newContinuationToken == null) {
        globals.talker?.info('No continuation token found, terminating.');
        return null;
      }
      return newContinuationToken;
    } catch (error) {
      globals.talker?.error('Error fetching chat messages: $error');
      return continuationToken; // Retry with the same token
    }
  }

  Future<void> startFetchingChat() async {
    var continuationToken = await fetchInitialContinuationToken();
    if (continuationToken == null) {
      globals.talker?.error('Failed to fetch initial continuation token.');
      return;
    }

    while (continuationToken != null) {
      if (_chatStreamController.isClosed) return;
      continuationToken = await fetchChatMessages(continuationToken);
      await Future.delayed(const Duration(seconds: 5)); // 5-second pause
    }
  }
}

Future<String?> getLiveVideoId(String channelURL) async {
  // Send GET request to the YouTube channel's live streams page
  var response = await http.get(Uri.parse(channelURL));
  if (response.statusCode != 200) {
    globals.talker?.error(
        'Failed to retrieve the page. Status code: ${response.statusCode}');
    return null;
  }

  // Extract the ytInitialData JSON data from the page content
  var match = RegExp(r'ytInitialData\s*=\s*({.*?});</script>')
      .firstMatch(response.body);
  if (match == null) {
    globals.talker?.error('Failed to find ytInitialData in the page content.');
    return null;
  }

  var ytInitialData = json.decode(match.group(1)!);

  // Navigate through the JSON data to find the live video ID
  try {
    var tabs =
        ytInitialData['contents']['twoColumnBrowseResultsRenderer']['tabs'];
    for (var tab in tabs) {
      if (tab is Map &&
          tab['tabRenderer'] != null &&
          tab['tabRenderer']['selected'] != null &&
          tab['tabRenderer']['content'] != null) {
        var contents =
            tab['tabRenderer']['content']['richGridRenderer']['contents'];
        for (var content in contents) {
          if (content is Map &&
              content['richItemRenderer'] != null &&
              content['richItemRenderer']['content'] != null &&
              content['richItemRenderer']['content']['videoRenderer'] != null &&
              content['richItemRenderer']['content']['videoRenderer']
                      ['upcomingEventData'] ==
                  null) {
            var videoId = content['richItemRenderer']['content']
                ['videoRenderer']['videoId'];
            return videoId;
          }
        }
      }
    }
  } catch (e) {
    globals.talker?.error('Error parsing ytInitialData: $e');
    return null;
  }

  globals.talker?.info('No live video found.');
  return null;
}
