import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'home_screen');
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/Assets/raining_sun.png'),
                      ),
                    ),
                  ),
                  NeumorphicText(
                    "Weatherly",
                    style: NeumorphicStyle(
                      color: Colors.black38,
                      depth: 10,
                      intensity: 1,
                      shadowLightColor: Colors.white,
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Colors.black26,
                strokeAlign: 1,
                strokeWidth: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
