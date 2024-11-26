import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hustlehub/services/auth_services.dart';
import 'package:hustlehub/services/firestoreDataBase.dart';
import 'package:hustlehub/users/models/usermodel.dart';
import 'package:hustlehub/utils/constants.dart';
import 'package:hustlehub/utils/controller.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kBgColor,
          ),
      backgroundColor: kBgColor,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(AuthServices().getUser())
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              UserModel user = UserModel.fromMap(snapshot.data!.data()!);

              return Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(clipBehavior: Clip.none, children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile!)
                            : user.image == null || user.image!.isEmpty
                                ? const AssetImage("assets/images/account.png")
                                : NetworkImage(user.image!),
                      ),
                      Positioned(
                          right: -5,
                          bottom: 15,
                          child: GestureDetector(
                            onTap: () {
                              pickImage(context);
                            },
                            child: const CircleAvatar(
                              radius: 15,
                              child: Icon(Icons.edit),
                            ),
                          ))
                    ]),
                    ksizedBoxHeight,
                    Row(
                      
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 30,
                        ),
                        widthInRow,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name",
                              style: TextStyle(
                                  color: kfontColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              user.name,
                              style: const TextStyle(
                                  color: kfontColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    kheightinRec,
                    kheightinRec,
                    Row(
                      children: [
                        const Icon(
                          Icons.mail_outline,
                          size: 30,
                        ),
                        widthInRow,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                  color: kfontColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                  color: kfontColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    kheightinRec,
                    kheightinRec,
                    Row(
                      children: [
                        const Icon(
                          Icons.phone_android_sharp,
                          size: 30,
                        ),
                        widthInRow,
                        GestureDetector(
                          onTap: (){
                            showDialog(context: context, builder: (context)=>AlertDialog(
                              title: const Text("Edit your phone number"),
                              content: TextField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintText: user.phone,
                                  
                                ),
                                ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      // Update title and description
                                      FirestoreServices().updateData(phoneController.text, 'phone');
                                      Navigator.pop(context);
                                    },
                                    child:  const Text("OK"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                              ],
                            ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Phone",
                                style: TextStyle(
                                    color: kfontColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                user.phone,
                                style: const TextStyle(
                                    color: kfontColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          }),
    ));
  }
}
