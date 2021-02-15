class CurrentWeather {
  String name;
  String latitude, longitude;
  double temp;
  String pressure;
  String windSpeed;
  String degree;
  int id;
  String main;
  String description;
  String icon;
  String humidity;
  String max_temp;

  CurrentWeather(
      {this.name,
      this.latitude,
      this.longitude,
      this.temp,
      this.pressure,
      this.windSpeed,
      this.id,
      this.main,
      this.description,
      this.degree,
      this.icon,
      this.humidity,
      this.max_temp});

  factory CurrentWeather.fromJson(Map<String, dynamic> map) {
    return CurrentWeather(
        name: map["name"].toString(),
        latitude: map["latitude"].toString(),
        longitude: map["longitude"].toString(),
        temp: map["temp"],
        pressure: map["pressure"].toString(),
        windSpeed: map["windSpeed"].toString(),
        id: map["id"],
        main: map["main"].toString(),
        description: map["description"].toString(),
        degree: map["degree"].toString(),
        icon: map["icon"].toString(),
        humidity: map["humidity"].toString(),
        max_temp: map["temp_max"].toString());
  }
  // CurrentWeather.fromJson(Map<String,dynamic> map){
  //
  //       // this.name= map["name"];
  //       // this.latitude= map["latitude"];
  //       // longitude= map["longitude"];
  //       // temp= map["temp"];
  //       // pressure = map["pressure"];
  //       // windSpeed= map["windSpeed"];
  //       // id= map["id"];
  //       // main= map["main"];
  //       // description= map["description"];
  //       // degree= map["degree"];
  //       // icon=map["icon"];
  //       // humidity =map["humidity"];
  //       // max_temp= map["temp_max"];
  //   CurrentWeather(
  //               name: map["name"],
  //               latitude: map["latitude"],
  //               longitude: map["longitude"],
  //               temp: map["temp"],
  //               pressure: map["pressure"],
  //               windSpeed: map["windSpeed"],
  //               id: map["id"],
  //               main: map["main"],
  //               description: map["description"],
  //               degree: map["degree"],
  //               icon:map["icon"],
  //               humidity: map["humidity"],
  //               max_temp: map["temp_max"]
  //             );
  //             print(this.name);
  // }

}
