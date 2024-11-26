import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hustlehub/users/widgets/recommendationWidget.dart';
import 'package:hustlehub/utils/controller.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routeConstants.dart';
import '../../services/auth_services.dart';
import '../../services/firestoreDataBase.dart';
import '../../utils/constants.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({
    super.key,
  });

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  FirestoreServices firestoreServices = FirestoreServices();
  bool showAll = false;
  bool recommandations = true;
  String? userRole;
  String? userName;
  String? userEmail;
  String? userPhone;
  Future<void> _getUserData() async {
    String? userId = AuthServices().getUser();
    if (userId == null) {
      print("User ID is null.");
      return;
    }
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(AuthServices().getUser())
          .get();

      setState(() {
        userRole = userDoc['role'];
        userName = userDoc['name'];
        userEmail = userDoc['email'];
        userPhone = userDoc['phone'];
      });
    } catch (e) {
      print("Error retrieving user data: $e");
    }
  }



 

 

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          backgroundColor: kBgColor,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            "Hustlehub",
            style: TextStyle(
                fontFamily: ktitleText,
                fontWeight: FontWeight.w600,
                fontSize: 30),
          ),
          centerTitle: true,
          leading: PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                Navigator.pushNamed(context, AppRoute.savedJobsScreen);
              } else if (value == 2) {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: const Icon(
              Icons.list,
              size: 30,
            ),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 1,
                child: Text('Saved Jobs'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Logout'),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.notificationScreen);
              },
              child: const Icon(
                Icons.notifications_outlined,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
              backgroundColor: kcontainerColor,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 15),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: ktextColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(DateTime.now().toString())),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: ktextColor),
                  )
                ],
              ),
              const Text(
                "Find Your Perfect Job",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showAll = false;
                        recommandations = true;
                      });
                    },
                    child: const Text(
                      "Recommendations",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kfontColor),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          recommandations = false;
                          showAll = true;
                        });
                      },
                      child: const Text(
                        "Show All",
                        style: TextStyle(color: kshowAllColor),
                      ))
                ],
              ),
              if (showAll)
                FutureBuilder(
                  future: fetchAndDisplayAllJobs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No data yet'),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                           

                            Map<String,dynamic> data = {
                                    'userName':userName,
                                    'userEmail':userEmail,
                                    'userPhone':userPhone,
                                    'docId':snapshot.data![index]['docId'],
                                    'companyName':snapshot.data![index]['companyName'],
                                    'jobTitle':snapshot.data![index]['jobTitle'],
                                    'jobDetails':snapshot.data![index]['jobDetails'],
                                  };
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                          context, AppRoute.jobDetailScreen,
                                          arguments: data)
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: RecommendationWidget(
                                  jobDetails: snapshot.data![index],
                                  index: index,
                                ));
                          },
                        ),
                      );
                    }
                  },
                )
              else if (recommandations)
                userRole == null
                    ? const Center(child: CircularProgressIndicator())
                    : FutureBuilder(
                        future: fetchRecommendedajobs(userRole: userRole!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No data yet'),
                            );
                          } else {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Map<String,dynamic> data = {
                                    'userName':userName,
                                    'userEmail':userEmail,
                                    'userPhone':userPhone,
                                    'docId':snapshot.data![index]['docId'],
                                    'companyName':snapshot.data![index]['companyName'],
                                    'jobTitle':snapshot.data![index]['jobTitle'],
                                    'jobDetails':snapshot.data![index]['jobDetails'],
                                  };
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                                AppRoute.jobDetailScreen,
                                                arguments:
                                                    data)
                                            .then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: RecommendationWidget(
                                        jobDetails: snapshot.data![index],
                                        index: index,
                                      ));
                                },
                              ),
                            );
                          }
                        },
                      )
            ],
          ),
        ),
      ),
    );
  }
}
