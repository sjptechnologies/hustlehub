import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hustlehub/users/screens/welcomeScreen.dart';
import 'package:hustlehub/utils/constants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        (){
        if (mounted) { // Check if the widget is still mounted
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        }});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBgColor,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            "Hustlehub",
            style: TextStyle(
                fontFamily: ktitleText,
                fontWeight: FontWeight.w600,
                fontSize: 30),
          ),
          centerTitle: true,
        ),
        backgroundColor: kBgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              ksizedBoxHeight,
              Image.asset('assets/images/splashImage.png'),
              ksizedBoxHeight,
              Container(
                height: 5,
                color: kfontColor,
              ),
              ksizedBoxHeight,
              const Text(
                "Best Way to Find Your Dream Job",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              ksizedBoxHeight,
              ksizedBoxHeight,
              Container(
                width: 160,
                padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: ktextColor,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Get Started",
                      style: TextStyle(color: kfontColor),
                    ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          8), // Set border radius for rounded corners
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: kfontColor, // Background color
                        child: const Icon(
                          Icons.chevron_right,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
