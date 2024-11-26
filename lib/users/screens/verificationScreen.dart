// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/utils/constants.dart';


// ignore: must_be_immutable
class VerificationScreen extends StatefulWidget {
    Map<String,dynamic>? user;

  VerificationScreen({super.key,required this.user});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController _codeController = TextEditingController();

  bool get _isButtonEnabled {
    return _codeController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBgColor,
          surfaceTintColor: Colors.transparent,
          title: Text(
            "Hustlehub",
            style: TextStyle(
                fontFamily: ktitleText,
                fontWeight: FontWeight.w600,
                fontSize: 30),
          ),
          centerTitle: true,
        ),
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verification",
                style: TextStyle(
                    color: kfontColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              kheightinRec,
              Text(
                "To finish registration, please enter the verification code we gave you. ",
                style: TextStyle(
                  color: ktextColor,
                  fontSize: 15,
                ),
              ),
              ksizedBoxHeight,
              kheightinRec,
              Column(
                children: [
                  Material(
                    color: kcontainerColor,
                    borderRadius: BorderRadius.circular(15),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _codeController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        border: InputBorder.none, // Removes the default border
                      ),
                    ),
                  ),
                  kheightinRec,
                  kheightinRec,
                  Text(
                    "Didn't recieve the code?",
                    style: TextStyle(color: kfontColor),
                  ),
                  kheightinRec,
                  Text(
                    "Resend code by SMS ",
                    style: TextStyle(color: kshowAllColor),
                  ),
                  kheightinRec,
                  Text(
                    "Resend code by phone call  ",
                    style: TextStyle(color: kshowAllColor),
                  ),
                  kheightinRec,
                  kheightinRec,
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          if(_isButtonEnabled){
                            // print('--------------------------');
                            // print(widget.user);
                            // print('-----------------------------');
                          Navigator.pushReplacementNamed(
                              context,
                              AppRoute.jobVerificaionScreen,arguments: widget.user
                            );
                          }
                          else{
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You should fill the fields')));
                      }
                        },
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 13)),
                          // ignore: deprecated_member_use
                          backgroundColor: MaterialStateProperty.all(
                              _isButtonEnabled ? Colors.black : ktextColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Set border radius
                            ),
                          ),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
