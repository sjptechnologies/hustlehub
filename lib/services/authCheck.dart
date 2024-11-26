import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hustlehub/company/screens/home.dart';
import 'package:hustlehub/users/screens/rootScreen.dart';
import 'package:hustlehub/users/screens/splashScreen.dart';
import 'package:hustlehub/utils/constants.dart';


class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading');
          }
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;

            if (user == null) {
              print('data');
              return const SplashScreen();
            } else {
              return 
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(user.uid)
                      .get(),
                  builder: (context, userSnapshot) {
                    if(userSnapshot.connectionState ==ConnectionState.waiting){
                              return Scaffold(body: Center(child: CupertinoActivityIndicator(),));
                            }

                    if (userSnapshot.hasData && userSnapshot.data!.exists) {
                      return RootScreen();
                    } else {
                      return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('Companies')
                              .doc(user.uid)
                              .get(),
                          builder: (context, companySnapshot) {
                            if(companySnapshot.connectionState ==ConnectionState.waiting){
                              return Scaffold(body: Center(child: CupertinoActivityIndicator(),));
                            }

                            if (companySnapshot.hasData &&
                                companySnapshot.data!.exists) {
                              return CompanyHomeScreen();
                            } else {
                              print('hhhhhh');
                              return SplashScreen();
                            }
                          });
                    }
                  });
            }
          }
          return const Center(
            child: CircularProgressIndicator(
              color: kfontColor,
            ),
          );
        });
  }
}
