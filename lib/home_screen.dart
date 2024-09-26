import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
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
        ],
      ),
    );
  }
}
