import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:irllink/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;

  group('App test', () {
    setUpAll(() async {
      await app.main();
    });

    setUp(() async {});

    tearDown(() {});

    testWidgets('We can navigate to home page', (WidgetTester tester) async {
      await tester.pumpWidget(const app.Main());
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('maybe_later_key')), findsOneWidget);
    });
  });
}
