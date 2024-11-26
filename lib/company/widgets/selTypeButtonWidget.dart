import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelTypeButtonWidget extends StatelessWidget {
  String selType;
  Color color;
SelTypeButtonWidget({super.key,required this.selType,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: color
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(child: Text(selType,style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold
      ),)),
    );
  }
}