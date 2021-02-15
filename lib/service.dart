import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/WeatherModel.dart';

class Services {
  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location service are disabled");
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied permanently");
    }
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission != LocationPermission.whileInUse &&
          locationPermission != LocationPermission.always) {
        return Future.error('Location permissions are denied ');
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getWeather() async {
    var longitude, latitude;
    Position position = await getPosition();
    longitude = position.longitude;
    latitude = position.latitude;
    var url =
        "https://api.openweathermap.org/data/2.5/find?lat=$latitude&lon=$longitude&cnt=1&appid=82953d4cf46d452a6ddb316da72900e6";
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        var map = decodedData["list"][0];

        var result = {
          "name": map["name"],
          "latitude": map["coord"]["lat"],
          "longitude": map["coord"]["long"],
          "temp": map["main"]["temp"],
          "pressure": map["main"]["pressure"],
          "windSpeed": map["wind"]["speed"],
          "degree": map["deg"],
          "id": map["weather"][0]["id"],
          "main": map["weather"][0]["main"],
          "description": map["weather"][0]["description"],
          "icon": map["weather"][0]["icon"],
          "humidity": map["main"]["humidity"],
          "max_temp": map["main"]["temp_max"],
        };
        print(result);
        return CurrentWeather.fromJson(result);
        // return result;

      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
