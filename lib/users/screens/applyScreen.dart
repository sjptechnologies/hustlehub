import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustlehub/services/appliedJobsDatabase.dart';
import 'package:hustlehub/services/userDataBase.dart';
import 'package:hustlehub/users/widgets/ApplyTextFieldWidget.dart';
import 'package:hustlehub/utils/constants.dart';
import 'package:hustlehub/utils/controller.dart';

class ApplyScreen extends StatefulWidget {
  Map<String, dynamic> jobData;
  ApplyScreen({super.key, required this.jobData});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController introController = TextEditingController();

  AppliedJobsDatabase ajdb = AppliedJobsDatabase();
  UserDataBase udb = UserDataBase();

  bool isLoading = false;

  PlatformFile? resume;

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ApplyTextFieldWidget(controller: nameController, hintText: 'Name'),
            ksizedBoxHeight,
            ApplyTextFieldWidget(
                controller: emailController, hintText: 'Email'),
            ksizedBoxHeight,
            ApplyTextFieldWidget(
              controller: phoneController,
              hintText: 'Phone No',
              type: 'number',
            ),
            ksizedBoxHeight,
            ApplyTextFieldWidget(
                controller: introController,
                hintText: 'Brief indroduction about you'),
            ksizedBoxHeight,
            GestureDetector(
              onTap: () async {
                final file = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );
                if (file != null) {
                  resume = file.files.single;
                  setState(() {});
                }
              },
              child: Container(
                child: Center(
                    child: Text(resume != null
                        ? resume!.name.toString()
                        : 'Attach your resume')),
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            ksizedBoxHeight,
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () async {
            
                    

                    try {
                      setState(() {
                        isLoading = true;
                      });

                      if (resume != null) {
                        await storeApplicationtoFireStore(
                            companyId: widget.jobData['company_id'],
                            jobId: widget.jobData['job_title'],
                            name: nameController.text,
                            email: emailController.text,
                            phno: phoneController.text,
                            indro: introController.text,
                            resume: File(resume!.path!));

                        await ajdb.insertValue(
                          opportunity_type: widget.jobData['oppurtunity_type'],
                          companyId: widget.jobData['company_id'],
                          jobTime: widget.jobData['job_time'],
                          perks: widget.jobData['perks'],
                          preference: widget.jobData['preference'],
                          description: widget.jobData['description'],
                          openings: widget.jobData['openings'],
                          skill: widget.jobData['skill'],
                          title: widget.jobData['job_title'],
                          companyName: widget.jobData['company_name'],
                          location: widget.jobData['job_location'],
                          salary: widget.jobData['salary'],
                          jobType: widget.jobData['job_type'],
                          oppurtunityType: widget.jobData['oppurtunity_type'],
                          dateOfPost: widget.jobData['date'],
                          experience: widget.jobData['experience'],
                          applicationCount: widget.jobData['application_count'],
                        );
                        await udb.insertValue(companyId: widget.jobData['company_id'], jobId: widget.jobData['job_title'], name: nameController.text, email: emailController.text, phone: phoneController.text,);
                        udb.retrieveValue();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Application sent successfully')));
                        isLoading = false;
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No resume attached')));
                      }
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));

                      isLoading = false;
                      setState(() {});
                    } finally {
                      isLoading = false;
                      setState(() {});
                    }
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
                  child: isLoading
                      ? CupertinoActivityIndicator(
                          color: Colors.white30,
                        )
                      : const Text(
                          "Apply",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
            ),
          ],
        ),
      ),
    ));
  }
}
