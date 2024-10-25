import 'dart:ui';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_app2/home_screen.dart';
import 'package:weather_app2/weather_logic.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  WeatherLogic weatherLogic = WeatherLogic();
  Position? _currentPosition;
  double _latitude = 0.0;
  double _longitude = 0.0;

  int _temp_current = 0;
  String cityName = '';

  @override
  void initState() {
    super.initState();
    weatherLogic.getPosition();
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Scaffold(
        body: Stack(
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
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/rainy_img.png'),
                  ),
                  Container(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        'Weather',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 62,
                              color: Colors.white,
                            ),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Text(
                      'ForeCasts',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 57,
                            color: Color(0xFFFDDB130),
                          ),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          onPressed: () {
                            print('Clicked!');
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                // Choose the transition type
                                child: HomeScreen(),
                                duration: Duration(
                                    milliseconds: 700), // Optional: Duration
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFDDB130),
                            minimumSize: Size(220, 50),
                          ),
                          child: Text(
                            'Get Start',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 22,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

