import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherLogic {

  Position? _currentPosition;
  double _latitude = 0.0;
  double _longitude = 0.0;

  Temperature? _temp_current;
  String? _cityName;
  DateTime? _date;

  Future<Position?> getPosition() async {
    try {
      Position position = await _determinePosition();
      _currentPosition = position;// This will print the actual Position data
      _latitude = position.latitude;
      _longitude = position.longitude;
    } catch (e) {
      print('Error occurred: $e'); // Handle any errors
    }
  }

  Future<Weather> getWeatherDetails([String? city]) async {

    WeatherFactory wf = new WeatherFactory("cdda0e5193beb9fd0b86f9f6a53ab3d8", language: Language.ENGLISH);
    Weather w;
    if(city != null) {
      w = await wf.currentWeatherByCityName(city);
    } else {
      w = await wf.currentWeatherByLocation(_latitude, _longitude);
    }

    return w;

  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
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
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}