import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:weather_app2/weather_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Weather? _weather; // Make _weather nullable
  late WeatherLogic _weatherLogic; // Declare _weatherLogic as late
  late Image image;

  @override
  void initState() {
    super.initState();
    _weatherLogic = WeatherLogic(); // Initialize _weatherLogic here
    _initializeFields();
  }

  void _setWeatherIcon(int code) {
    setState(() {
      switch (code) {
        case >= 200 && < 300:
          image = Image.asset('assets/1.png');
        case >= 300 && < 400:
          image = Image.asset('assets/2.png');
        case >= 500 && < 600:
          image = Image.asset('assets/3.png');
        case >= 600 && < 700:
          image = Image.asset('assets/4.png');
        case >= 700 && < 800:
          image = Image.asset('assets/5.png');
        case == 800:
          image = Image.asset('assets/6.png');
        case > 800 && <= 804:
          image = Image.asset('assets/7.png');
        default:
          image = Image.asset('assets/7.png');
      }
    });
  }


  Future<void> _initializeFields() async {
    try {
      await _weatherLogic.getPosition();
      Weather? weatherDetails = await _weatherLogic.getWeatherDetails();
      setState(() {
        _weather = weatherDetails; // Update the state with the new weather data
        _setWeatherIcon(_weather?.weatherConditionCode ?? 801);
        print(_weather);
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            set_background(screenWidth),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  width: 244,
                  height: 220,
                  child: Center(
                    child: image
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  height: 55,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: _weather != null // Check if _weather is not null
                          ? Text(
                        '${_weather!.temperature!.celsius!.round()}°C', // Use null check operator
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                          : CircularProgressIndicator(), // Display a loading indicator while waiting for data
                    ),
                  ),
                ),
                Container(
                  height: 38,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Text(
                        '📍${_weather!.areaName}',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 38,
                    child: Center(
                      child: Text(
                        DateFormat('EEEE dd •').add_jm().format(_weather!.date!),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 336,
                  height: 198,
                  child: Image.asset('assets/house.png'),
                ),
                Container(
                  width: screenWidth,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white60,
                      width: 4.0, // Width of the border
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 2, // Spread of the shadow
                        blurRadius: 8, // Blurring effect
                        offset: Offset(0, 4), // Offset of the shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/11.png',
                                  width: 70,
                                  height: 70,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Sunrise',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.grey),
                                      ),
                                      Text(
                                        DateFormat().add_jm().format(_weather!.sunrise!),
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/12.png',
                                  width: 70,
                                  height: 70,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Sunset',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.grey),
                                      ),
                                      Text(
                                        DateFormat().add_jm().format(_weather!.sunset!),
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/13.png',
                                  width: 70,
                                  height: 70,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Temp Max',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.grey),
                                    ),
                                    Text(
                                      "${_weather!.tempMax!.celsius!.round()} °C",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Image.asset(
                                    'assets/14.png',
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Temp Min',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.grey),
                                    ),
                                    Text(
                                      "${_weather!.tempMin!.celsius!.round()} °C",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget set_background(double screenWidth) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(0, -1),
          child: Container(
            width: screenWidth,
            height: 800,
            decoration: BoxDecoration(
                color: Colors.deepPurple, shape: BoxShape.rectangle),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(1, 0),
          child: SizedBox(
            width: screenWidth,
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF3E2D8F), shape: BoxShape.rectangle),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, 1),
          child: Container(
            width: screenWidth,
            height: 100,
            decoration: BoxDecoration(
                color: Color(0xFFF9D52AC), shape: BoxShape.rectangle),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
