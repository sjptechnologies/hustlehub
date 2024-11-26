import 'package:flutter/material.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Find Your Dream Job",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                          AppRoute.loginScreen,arguments: 'company');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                color: ktextColor,
                              )
                            ]),
                        child: Image.asset(
                          'assets/images/welcomeImage1.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                    kheightinRec,
                    const Text(
                      "Company",
                      style: TextStyle(
                          color: kfontColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                            AppRoute.loginScreen,arguments: 'jobseeker');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                color: ktextColor,
                              )
                            ]),
                        child: Image.asset(
                          'assets/images/welcomeImage2.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                    kheightinRec,
                    const Text(
                      "Job Seeker",
                      style: TextStyle(
                          color: kfontColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
