import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:irllink/src/core/failure.dart';

Future<Either<Failure, Position>> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Left(
      Failure('Location services are disabled.'),
    );
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Left(
        Failure('Location permissions are denied.'),
      );
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.

    // TODO(LezdCS): await Geolocator.openLocationSettings();
    return Left(
      Failure(
        'Location permissions are permanently denied, we cannot request permissions.',
      ),
    );
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  Position p = await Geolocator.getCurrentPosition();
  return Right(p);
}
