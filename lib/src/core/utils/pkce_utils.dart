import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class PKCEUtils {
  /// Generates a random code verifier for PKCE
  ///
  /// The code verifier is a random string between 43 and 128 characters long,
  /// containing only the characters [A-Z], [a-z], [0-9], "-", ".", "_", and "~".
  static String generateCodeVerifier() {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    final random = Random.secure();
    final length = random.nextInt(86) + 43; // Random length between 43 and 128

    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  /// Generates a code challenge from a code verifier using SHA-256
  ///
  /// The code challenge is the base64url-encoded SHA-256 hash of the code verifier,
  /// with padding characters removed.
  static String generateCodeChallenge(String codeVerifier) {
    final bytes = utf8.encode(codeVerifier);
    final digest = sha256.convert(bytes);
    final base64Url = base64UrlEncode(digest.bytes);
    return base64Url.replaceAll('=', '');
  }
}
