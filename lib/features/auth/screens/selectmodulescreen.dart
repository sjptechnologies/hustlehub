import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustlehub/main.dart';
class JobSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            SizedBox(height: 40.h),
            Text(
              'HustleHub',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            SizedBox(height: 20.0),

            // Subtitle
            Text(
              'Find Your Perfect Job',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 20.0),

            // Image buttons for Company and Job Seeker
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Company Button
                  GestureDetector(
                    onTap: () {
                      // Handle navigation to company screen
                      print("Company button pressed");
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 160.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage('asset/images/company.png'), // Replace with your actual image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Company',
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Job Seeker Button
                  GestureDetector(
                    onTap: () {
                      // Handle navigation to job seeker screen
                      print("Job Seeker button pressed");
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 160.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage('asset/images/job_seeker.png'), // Replace with your actual image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Job Seeker',
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),

            // Login as Admin Button
            TextButton(
              onPressed: () {
                // Handle login as admin
                print("Login as Admin button pressed");
              },
              child: Text(
                'Login as Admin',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
