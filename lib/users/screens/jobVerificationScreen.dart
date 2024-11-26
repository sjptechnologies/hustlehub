import 'package:flutter/material.dart';

import '../../routes/routeConstants.dart';
import '../../services/firestoreDataBase.dart';
import '../../utils/constants.dart';
import '../models/usermodel.dart';
import '../widgets/jobVerificationWidget.dart';

// ignore: must_be_immutable
class JobVerificationScreen extends StatefulWidget {
    Map<String,dynamic>? user;

  JobVerificationScreen({super.key,this.user});

  @override
  State<JobVerificationScreen> createState() => _JobVerificationScreenState();
}

class _JobVerificationScreenState extends State<JobVerificationScreen> {


  Map<String,dynamic>? userData;

    FirestoreServices firestoreServices = FirestoreServices();

    List<String> jobs = [];




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "What kind of jobs are you looking for?",
                style: TextStyle(
                  color: kfontColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    JobVerificationWidget(
                      title: "Programming",
                      icon: const Icon(Icons.code,size: 50,),
                      jobs: jobs,
                    ),
                    JobVerificationWidget(
                      title: "Marketing",
                      icon: const Icon(Icons.campaign,size: 50,),
                      jobs: jobs,
                    ),
                    JobVerificationWidget(
                      title: "Healthcare",
                      icon: const Icon(Icons.medical_services,size: 50,),
                      jobs: jobs,
                    ),
                    JobVerificationWidget(
                      title: "Design",
                      icon: const Icon(Icons.design_services,size: 50,),
                      jobs: jobs,
                    ),
                    JobVerificationWidget(
                      title: "Aviation",
                      icon: const Icon(Icons.flight_outlined,size: 50,),
                      jobs: jobs,
                    ),
                    JobVerificationWidget(
                      title: "Construction",
                      icon: const Icon(Icons.engineering,size: 50,),
                      jobs: jobs,
                    ),
                  ]),
                  kheightinRec,
                  kheightinRec,
              SizedBox(
                width: 200,
                child: TextButton(
                    onPressed: () async{
                      userData ={
                        'name':widget.user?['name'],
                        'email':widget.user?['email'],
                        'role':widget.user?['role'],
                        'country':widget.user?['country'],
                        'phone':widget.user?['phone'],
                        'jobs':jobs
                      };
                      await firestoreServices.storeData(UserModel(name: userData!['name'], email: userData!['email'], country: userData!['country'], jobs: userData!['jobs'], phone: userData!['phone'],role:userData!['role']));
                      // print(userData);

                      Navigator.pushReplacementNamed(
                          // ignore: use_build_context_synchronously
                          context,
                          AppRoute.rootScreen);
                    },
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 13)),
                      backgroundColor: const WidgetStatePropertyAll(Colors.black),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25), // Set border radius
                        ),
                      ),
                    ),
                    child: const Text(
                      "Find Jobs",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
