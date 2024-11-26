import 'package:flutter/material.dart';
import 'package:hustlehub/utils/constants.dart';

// ignore: must_be_immutable
class FilterTextFieldWidget extends StatefulWidget {
  String? hintText;
  Icon? preicon;
  Icon? suficon;
  FilterTextFieldWidget({super.key,this.hintText,this.preicon,this.suficon});

  @override
  State<FilterTextFieldWidget> createState() => _FilterTextFieldWidgetState();
}

class _FilterTextFieldWidgetState extends State<FilterTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: widget.preicon,
        prefixIconColor: ktextColor,
        suffixIcon: widget.suficon,
        suffixIconColor: ktextColor,
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ktextColor, // Change the border color
            width: 0.5, // Change the border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Optional: set border radius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ktextColor, // Change the border color
            width: 1.0, // Change the border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Optional: set border radius
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: ktextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}