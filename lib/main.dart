import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irl_link/Widget/WebPageView.dart';
import 'package:irl_link/views/settingsView.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:split_view/split_view.dart';

import 'Model/WebPage.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeContainer(),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer>
    with TickerProviderStateMixin {
  late TabController _tabController = new TabController(length: 3, vsync: this);
  late double upperViewSize;
  late double height;
  double width = 0;
  RxBool sound = true.obs;
  SplitViewController splitViewController =
      new SplitViewController(limits: [null, WeightLimit(min: 0.12)]);

  RxList<WebPage> internetPages = <WebPage>[].obs;

  @override
  void initState() {
    super.initState();
    _tabController.addListener(_handleTabSelection);

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    WebPage page1 = new WebPage("Twitch", "https://www.twitch.tv", true);
    WebPage page2 = new WebPage("Youtube", "https://www.youtube.com", true);
    WebPage page3 =
        new WebPage("Steam", "https://www.steamcommunity.com/id/Lezd/", true);

    internetPages.add(page1);
    internetPages.add(page2);
    internetPages.add(page3);

    new Future.delayed(
      Duration.zero,
      () {
        upperViewSize = MediaQuery.of(context).size.height / 2;
        height = MediaQuery.of(context).size.height;
        width = MediaQuery.of(context).size.width;
      },
    );
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => {
              FocusScope.of(context).unfocus(),
            },
            child: Container(
              constraints: BoxConstraints.expand(),
              child: SafeArea(
                child: SplitView(
                  controller: splitViewController,
                  gripColor: Color(0xFF222f3e),
                  gripColorActive: Color(0xFF222f3e),
                  gripSize: 20,
                  viewMode: SplitViewMode.Vertical,
                  indicator: SplitIndicator(
                    viewMode: SplitViewMode.Vertical,
                    color: Color(0xFF8395a7),
                  ),
                  activeIndicator: SplitIndicator(
                    color: Color(0xFF8395a7),
                    viewMode: SplitViewMode.Vertical,
                    isActive: true,
                  ),
                  children: [
                    _tabBarCustomWindows(),
                    _twitchChat(),
                  ],
                  onWeightChanged: (w) {
                    print("Horizon: $w");
                  },
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF222f3e),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: _bottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBar() {
    return Obx(
      () => Container(
        height: height * 0.07,
        child: Row(
          children: [
            Container(
              width: width * 0.6,
              height: double.maxFinite,
              child: TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  fillColor: Color(0xFF8395a7),
                  filled: true,
                  hintText: 'Chat (stream offline)',
                  isDense: true,
                  contentPadding: EdgeInsets.only(bottom: 40 / 2, left: 5),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(0.0),
                    ),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: width * 0.2,
              height: double.maxFinite,
              child: InkWell(
                onTap: () {
                  sound.value = !sound.value;
                },
                child: Icon(
                  sound.value ? Icons.volume_up : Icons.volume_off,
                  color: sound.value ? Colors.grey : Color(0xFFd63031),
                  size: 22,
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            Container(
              width: width * 0.2,
              height: double.maxFinite,
              child: InkWell(
                onTap: () {
                  Get.to(SettingsView());
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.grey,
                  size: 22,
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xFF222f3e),
        ),
      ),
    );
  }

  Widget _tabBarCustomWindows() {
    return SizedBox(
      height: upperViewSize,
      width: width,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Color(0xFF222f3e),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.purple,
              labelPadding: EdgeInsets.symmetric(
                  horizontal: width / (internetPages.length > 2 ? 9 : 5)),
              tabs: List<Tab>.generate(
                internetPages.length,
                (int index) => Tab(
                  child: Text(
                    internetPages[index].title,
                    style: TextStyle(
                        color: _tabController.index == index
                            ? Colors.purple
                            : Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          child: TabBarView(
            controller: _tabController,
            children: List<TabBarPageWidget>.generate(
              internetPages.length,
              (int index) => TabBarPageWidget(internetPages[index].url),
            ),
          ),
        ),
      ),
    );
  }

  Widget _twitchChat() {
    return Container(
      width: width,
      padding: EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to the lezd_ chat room!",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFF222f3e),
      ),
    );
  }
}
