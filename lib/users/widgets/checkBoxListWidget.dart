import 'package:flutter/material.dart';

import '../../utils/constants.dart';


// ignore: must_be_immutable
class CheckBoxListWidget extends StatefulWidget {
  String? title;
  String? count;
  CheckBoxListWidget({super.key, this.title, this.count});

  @override
  State<CheckBoxListWidget> createState() => _CheckBoxListWidgetState();
}

class _CheckBoxListWidgetState extends State<CheckBoxListWidget> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity:
            const VisualDensity(vertical: -4), // Reduces the overall height
        checkColor: Colors.white,
        activeColor: kshowAllColor,
        value: _value,
        title: Text.rich(
          TextSpan(
            text: widget.title, // The text before the colored part
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black, // Color for the main text
            ),
            children: [
              TextSpan(
                text:
                    '(${widget.count})', // The text you want to color differently
                style: const TextStyle(
                  color: ktextColor, // Change the color of (20) here
                ),
              ),
            ],
          ),
        ),
        onChanged: (bool? value) {
          setState(() {
            _value = value!;
          });
        });
  }
}
