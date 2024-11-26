import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextButtonWidget extends StatefulWidget {
  String text;
  
  TextButtonWidget({super.key, required this.text});

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.black),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Set border radius
              ),
            ),
          ),
          child: Text(
            widget.text,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
