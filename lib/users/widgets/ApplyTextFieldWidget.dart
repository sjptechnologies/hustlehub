import 'package:flutter/material.dart';
import 'package:hustlehub/utils/constants.dart';

class ApplyTextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  String? type;
  ApplyTextFieldWidget({super.key,required this.controller,required this.hintText,this.type});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type == 'number'?TextInputType.phone:TextInputType.text,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: kfontColor,
                  width: 1
                )
              ),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: ktextColor,
                  width: 1
                )
              ),
            
            ),
          );
  }
}