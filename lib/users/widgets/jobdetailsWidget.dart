import 'package:flutter/material.dart';
import 'package:hustlehub/utils/constants.dart';


// ignore: must_be_immutable
class JobScreenWidget extends StatelessWidget {
  Icon icon ;
  String text;
  JobScreenWidget({super.key,required this.icon,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(left: 8,right: 8),
      decoration: BoxDecoration(
        color: kcontainerColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 5,),
          Text(text,style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12
          ),)
        ],
      ),
    );
  }
}