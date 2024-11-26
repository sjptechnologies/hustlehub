import 'package:flutter/material.dart';
import 'package:hustlehub/users/widgets/textButtonWidget.dart';
import 'package:hustlehub/utils/constants.dart';

class ProfileDetailsWidget extends StatefulWidget {
  bool isComplete;
  String title;
  ProfileDetailsWidget({super.key,required this.isComplete,required this.title});

  @override
  State<ProfileDetailsWidget> createState() => _ProfileDetailsWidgetState();
}

class _ProfileDetailsWidgetState extends State<ProfileDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kcontainerColor,
        borderRadius: BorderRadius.circular(10)
      ),
      width: MediaQuery.of(context).size.width/3,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.account_circle_outlined,color: kfontColor,),
          ),
          Text(widget.title,style: TextStyle(
            color: kfontColor,
            fontWeight: FontWeight.bold
          ),),
          TextButtonWidget(text: widget.isComplete?"Completed":"Complete")
        ],
      ),
    );
  }
}