import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:irllink/main.dart';
import 'package:irllink/src/core/depedency_injection.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App test', () {
    setUpAll(() async {
      await initializeDependencies();
    });

    setUp(() async {});

    tearDown(() {});

    testWidgets('We arrive on the login screen', (WidgetTester tester) async {
      await tester.pumpWidget(const Main());
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('maybe_later_key')), findsOneWidget);
    });
  });
}
