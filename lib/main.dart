import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustlehub/features/auth/screens/loginscreen.dart';
import 'package:hustlehub/features/auth/screens/selectmodulescreen.dart';
import 'package:hustlehub/features/auth/screens/splashscreen.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(412, 891),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context,child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily:'poppins'
          ),
          home: JobSelectionScreen(),
        );
      }
    ),
  );
}
