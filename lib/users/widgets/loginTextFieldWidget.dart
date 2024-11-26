import 'package:flutter/material.dart';
import 'package:hustlehub/utils/constants.dart';

// ignore: must_be_immutable
class LoginTextFieldWidget extends StatefulWidget {
  String text;
  bool obscure;
  TextEditingController controller;
  LoginTextFieldWidget({super.key,required this.text,required this.obscure,required this.controller});

  @override
  State<LoginTextFieldWidget> createState() => _LoginTextFieldWidgetState();
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {

  @override
  Widget build(BuildContext context) {
    return Material(
  color: kcontainerColor,
  borderRadius: BorderRadius.circular(15),
  child: TextField(
    controller: widget.controller,
    obscureText: widget.obscure,
    decoration: InputDecoration(
     suffixIcon: widget.text == "Password" // Show icon only for password field
              ? IconButton(
                  icon: Icon(
                    widget.obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: (){
                   setState(() {
                      widget.obscure = !widget.obscure;
                   });
                  }
                )
              : null,
      hintText: widget.text,
      hintStyle: const TextStyle(
        color: ktextColor
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      border: InputBorder.none, // Removes the default border
    ),
  ),
);

  }
}