import 'package:flutter/material.dart';
import 'package:hustlehub/utils/constants.dart';

// ignore: must_be_immutable
class CustomProgressIndicator extends StatelessWidget {
  double progress;
  CustomProgressIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Background container
        Container(
          width: screenWidth,
          height: 10,
          decoration: BoxDecoration(
            color: kcontainerColor, // Background color
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        // Foreground progress container
        Container(
          width: screenWidth * progress, // Adjust width based on progress
          height: 10,
          decoration: BoxDecoration(
            color: Colors.black, // Progress color
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
