import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title at the top
              Text(
                'HustleHub',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),

              // Illustration image (replace with actual image asset)
              Image.asset(
                'asset/images/job_search_illustration.png', // replace with your actual image path
                height: 250.0,
              ),
              SizedBox(height: 20.0),

              // Horizontal line divider
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 2.0,
                width: 100.0,
                color: Colors.black,
              ),

              // Tagline
              Text(
                'Best Way to Find Your Dream Job',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),

              // "Get Started" button
              ElevatedButton(
                onPressed: () {
                  // Action to navigate or other function
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  shadowColor: Colors.black.withOpacity(0.2),
                  elevation: 5.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(width: 10.0),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}