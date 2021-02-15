import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/WeatherModel.dart';
import 'service.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Services services = new Services();
  String bgImg;
  void initState() {
    setState(() {
      services.getWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height,
        w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: FutureBuilder(
      future: services.getWeather(),
      builder: (context, snapshot) {
        print(snapshot.data.toString());
        if (snapshot.hasData) {
          print(snapshot.data.pressure);
          setBg(snapshot.data.id);
          print(snapshot.data.id.toString());
          DateTime now = DateTime.now();
          var hour = now.hour.toString();
          var minutes = now.minute.toString();
          return RefreshIndicator(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: h,
                  width: w,
                  child: Stack(
                    children: [
                      Image.asset(
                        bgImg,
                        fit: BoxFit.cover,
                        height: h,
                        width: w,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.black38),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 150,
                                    ),
                                    Text(
                                      snapshot.data.name,
                                      style: GoogleFonts.lato(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      hour +
                                          ":" +
                                          minutes +
                                          "    " +
                                          now.day.toString() +
                                          "/" +
                                          now.month.toString() +
                                          "/" +
                                          now.year.toString(),
                                      style: GoogleFonts.lato(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (snapshot.data.temp - 273)
                                              .toStringAsFixed(2) +
                                          "  \u2103",
                                      style: GoogleFonts.lato(
                                          fontSize: 75,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Image.network(
                                            "https://openweathermap.org/img/wn/${snapshot.data.icon}@2x.png"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data.description,
                                          style: GoogleFonts.lato(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 40),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.white30)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Pressure',
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            snapshot.data.pressure,
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'mBar',
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Wind',
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            snapshot.data.windSpeed,
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'km/h',
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Humidity',
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            snapshot.data.humidity + '%',
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            '',
                                            style: GoogleFonts.lato(
                                                fontSize: 24,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onRefresh: services.getWeather);
        } else {
          return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent));
        }
      },
    ));
  }

  void setBg(int id) {
    if (id < 700)
      bgImg = 'assets/rainy.jpg';
    else if (id == 800)
      bgImg = 'assets/sunny.jpg';
    else if (id < 900) {
      bgImg = 'assets/cloudy.jpeg';
    }
  }
}
