import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_app2/home_screen.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {

  List<String> allCities = ['Karachi', 'Lahore', 'Khairpur', 'Islamabad'];
  List<String> cities = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     cities = List.from(allCities);
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:18.0),
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Search:', // Hint text
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 22),
                        prefixIcon: Icon(Icons.search), // Icon before the text
                      ),
                      onChanged: searchCity,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          final city = cities[index];
                          return ListTile(
                            title: Text(city),
                            onTap:() {
                              _controller.text = city;
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.scale,
                                  alignment: Alignment.center,
                                  // Choose the transition type
                                  child: HomeScreen(city: city),
                                  duration:
                                  Duration(milliseconds: 700), // Optional: Duration
                                ),
                              );
                            },
                          );
                        }
                    ),
                  )
                ],
              )
            ],
          ),
        ),
    );
  }

  void searchCity(String query) {
    final suggestions = allCities.where((city) {
    final cityTitle = city.toLowerCase();
    final input = query.toLowerCase();

    return cityTitle.contains(input);
    }).toList();

    setState(() {
      cities = suggestions;
    });
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
