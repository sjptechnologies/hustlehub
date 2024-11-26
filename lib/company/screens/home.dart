import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hustlehub/company/widgets/postedJobWidget.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/services/firestoreDataBase.dart';
import 'package:hustlehub/users/screens/splashScreen.dart';
import 'package:hustlehub/utils/constants.dart';


class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({super.key});

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {

FirestoreServices firestoreServices = FirestoreServices();
TextEditingController countController = TextEditingController();
 

  void refreshJobs() {
     if (mounted) { // Check if mounted before calling setState
      setState(() {}); // Trigger a rebuild
    }
  }
   
   String docId = FirebaseAuth.instance.currentUser!.uid;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          
          title: const Text(
              "Hustlehub",
              style: TextStyle(
                  fontFamily: ktitleText,
                  fontWeight: FontWeight.w600,
                  fontSize: 30),
            ),
            centerTitle: true,
          backgroundColor: kBgColor,
          actions: [
            PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(content: TextField(
                    controller: countController,
                    decoration: InputDecoration(
                      hintText: 'No. of Employees'
                    ),
                  ),
                  actions: [
                    TextButton(onPressed: (){
                      firestoreServices.updateEmployeeCount(data: int.parse(countController.text));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated Successfully')));
                      Navigator.pop(context);
                    }, child: Text('OK',style: TextStyle(
                      color: kfontColor
                    ),)),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Cancel',style: TextStyle(
                      color: kfontColor
                    ),))
                  ],
                    
                  );
                },);
              } else if (value == 2) {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreen(),), (route) => false,);
              }
            },
            icon: const Icon(
              Icons.list,
              size: 30,
            ),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 1,
                child: Text('Set Number of Employees'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Logout'),
              ),
            ],
          ),
           
          ],
        ),
        backgroundColor: kBgColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 15),
          child:FutureBuilder(
            future: firestoreServices.getJobData(),
             builder: (context, snapshot) {
               if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
               }
               else if(snapshot.hasError){
                return Center(child: Text(snapshot.error.toString()),);
               }
               else if(!snapshot.hasData || snapshot.data?.jobs == null || snapshot.data!.jobs!.isEmpty){
                return Center(child: Text('No data yet'),);
               }
               else{
                final company = snapshot.data!;
               return ListView.builder(
                itemCount: company.jobs?.length ?? 0,
                itemBuilder: (context, index) {

                  final jobData = company.jobs![index];
                  final companyData = company;

                  Map<String,dynamic> jobDetails = {
                    'docId':docId,
                    'jobId':jobData['jobTitle'],
                    'date':jobData['date'],
                    'applicationCount':jobData['applicationCount'],
                    'oppurtunityType':jobData['oppurtunityType'],
                    'jobTime':jobData['jobTime'],
                    'finalSalary':jobData['finalSalary'],
                    'preference':jobData['preference'],
                    'experience':jobData['experience'],
                    'skills':jobData['skills'],
                    'openingsCount':jobData['openingsCount'],
                    'jobLocation':jobData['jobLocation'],
                    'initialSalary':jobData['initialSalary'],
                    'currency':jobData['currency'],
                    'jobType':jobData['jobType'],
                    'perks':jobData['perks'],
                    'desc':jobData['desc'],
                    'applications':jobData['applications'],
                  };


                  //fecth company name and job title
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoute.postedJobDetailScreen,arguments: jobData);
                    },
                    child: PostedJobWidget(jobData: jobDetails,companyData: companyData,onJobDeleted: refreshJobs,)); // Pass job data to your widget
                },
               );
               }
             },
             )

        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () async{
           final result = await Navigator.pushNamed(context, AppRoute.addJobScreen);
          if (result == true) {
            refreshJobs();
          }
        
          },
          shape: CircleBorder(),
          backgroundColor: kfontColor,
          child: Icon(Icons.add,size: 30,),
          foregroundColor: Colors.white,
          
        ),
      ),
    );
  }
}