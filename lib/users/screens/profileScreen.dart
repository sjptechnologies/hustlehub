import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hustlehub/services/auth_services.dart';
import 'package:hustlehub/users/models/usermodel.dart';
import 'package:hustlehub/users/screens/splashScreen.dart';
import 'package:hustlehub/users/widgets/customProgressIdicator.dart';
import 'package:hustlehub/users/widgets/profileDetailsWidget.dart';
import 'package:hustlehub/utils/constants.dart';

import 'package:image_picker/image_picker.dart';

import '../../routes/routeConstants.dart';
import '../../utils/controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {




  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(
                color: kfontColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: kBgColor,
          actions: [ 
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreen(),), (route) => false,);
              },
            )
          ],
        ),
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(AuthServices().getUser())
                  .snapshots(),
              builder: (context, snapshot) {
                // print(AuthServices().getUser());
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  UserModel user = UserModel.fromMap(snapshot.data!.data()!);
                  bool isProfile1Completed = user.name.isNotEmpty && user.email.isNotEmpty && user.phone.isNotEmpty && user.country.isNotEmpty;
                  bool isProfile2Completed = user.role.isNotEmpty;
                  bool isProfile3Completed = user.jobs.isNotEmpty;
                  bool isProfile4Completed = user.image!= null; 
                  List<bool> indicator =[isProfile1Completed,isProfile2Completed,isProfile3Completed,isProfile4Completed];
                  int completedCount = indicator.where((isCompleted) => isCompleted).length;
                  double completedBar = completedCount /4;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ksizedBoxHeight,
                      GestureDetector(
                        onTap: () {
                          pickImage(context);
                          setState(() {
                            
                          });
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: imageFile != null
                              ? FileImage(imageFile!)
                              : user.image == null || user.image!.isEmpty ? const AssetImage("assets/images/account.png") :NetworkImage(user.image!),
                        ),
                      ),
                      kheightinRec,
                      Text(
                    
                        user.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        user.role,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: kfontColor),
                      ),
                      ksizedBoxHeight,
                      Text(
                        "Complete Your Profile ($completedCount/4)",
                        style: TextStyle(color: kfontColor, fontSize: 15),
                      ),
                      kheightinRec,
                      CustomProgressIndicator(progress: completedBar),
                      kheightinRec,
                      SizedBox(
                        height: 200,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ProfileDetailsWidget(title: 'Add Your Personal Details',isComplete: isProfile1Completed,),
                              ProfileDetailsWidget(title: 'Add Your Job Role',isComplete: isProfile2Completed,),
                              ProfileDetailsWidget(title: 'Add Your Destinations',isComplete: isProfile3Completed,),
                              ProfileDetailsWidget(title: 'Add Your Profile Image',isComplete: isProfile4Completed,)
                            ]),
                      ),
                      ksizedBoxHeight,
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.settingScreen);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kcontainerColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.settings_outlined),
                              widthInRow,
                              Text(
                                "Settings",
                                style: TextStyle(
                                    color: kfontColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                      ),
                      kheightinRec,
                      kheightinRec,
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kcontainerColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.chat_outlined),
                            widthInRow,
                            Text(
                              "Help",
                              style: TextStyle(
                                  color: kfontColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                      ksizedBoxHeight
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
