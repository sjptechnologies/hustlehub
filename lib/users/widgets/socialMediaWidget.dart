import 'package:flutter/material.dart';
import 'package:hustlehub/utils/constants.dart';

// ignore: must_be_immutable
class SocialMediaWidget extends StatelessWidget {
  Image image;
  SocialMediaWidget({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: kcontainerColor,
      child: image,
    );
  }
}