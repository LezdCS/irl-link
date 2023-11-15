import 'package:instant/instant.dart';

DateTime convertToDeviceTimezone(DateTime date) {
  return dateTimeToZone(
    zone: DateTime.now().timeZoneName,
    datetime: date,
  );
}
