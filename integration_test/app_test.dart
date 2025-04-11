import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:irllink/main.dart' as app;
import 'package:patrol/patrol.dart';

void main() {
  Get.testMode = true;

  patrolTest('App test', ($) async {
    // Start app initialization
    final appInit = app.main();

    // Wait for permission dialog and grant it
    await $.native.grantPermissionWhenInUse();

    // Wait for app initialization to complete
    await appInit;

    await $.pumpWidgetAndSettle(const app.Main());
    expect($(const Key('maybe_later_key')), findsOneWidget);
  });
}
