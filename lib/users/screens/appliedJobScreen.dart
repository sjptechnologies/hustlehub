import 'package:flutter/material.dart';
import 'package:hustlehub/services/appliedJobsDatabase.dart';
import 'package:hustlehub/services/firestoreDataBase.dart';
import 'package:hustlehub/services/userDataBase.dart';
import 'package:hustlehub/users/widgets/appliedJobWidget.dart';
import 'package:hustlehub/users/widgets/searchWidget.dart';
import 'package:hustlehub/utils/constants.dart';

class AppliedJobScreen extends StatefulWidget {
  const AppliedJobScreen({super.key});

  @override
  State<AppliedJobScreen> createState() => _AppliedJobScreenState();
}

class _AppliedJobScreenState extends State<AppliedJobScreen> {
  String _searchQuery = "";
  UserDataBase udb = UserDataBase();
  FirestoreServices firestoreServices = FirestoreServices();
  AppliedJobsDatabase ajdb = AppliedJobsDatabase();

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            children: [
              SearchWidget(
                onSearchChanged: _onSearchChanged,
              ),
              Expanded(
                child: FutureBuilder(
                  future: Future.wait([
                    ajdb.retrieveValue(), // Jobs from SQLite
                    udb.retrieveValue(), // User data from SQLite
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.data == null ||
                        snapshot.data![0].isEmpty ||
                        snapshot.data![1].isEmpty) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                    

                    // Data unpacking
                    List jobData = snapshot.data![0]; // Jobs data
                    List<Map<String, dynamic>> userData = snapshot.data![1]; // List of user records

                     List filteredJobs = jobData.where((job) {
                      final jobTitle = job['job_title']?.toLowerCase() ?? '';
                      final companyName =
                          job['company_name']?.toLowerCase() ?? '';
                      return jobTitle.contains(_searchQuery) ||
                          companyName.contains(_searchQuery);
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredJobs.length,
                      itemBuilder: (context, index) {
                        var job = filteredJobs[index];
                        List<Widget> appliedJobWidgets = [];

                        for (var user in userData) {
                          String userName = user['name'];
                          String userEmail = user['email'];
                          String userPhone = user['phone'];

                          appliedJobWidgets.add(
                            FutureBuilder<String?>(
                              future: firestoreServices.fetchStatusOfApplication(
                                companyId: job['company_id'],
                                jobId: job['job_title'],
                                name: userName,
                                email: userEmail,
                                phone: userPhone,
                              ),
                              builder: (context, statusSnapshot) {
                                if (statusSnapshot.connectionState == ConnectionState.waiting) {
                                  return const SizedBox.shrink(); // Skip showing loading for each status
                                } else if (statusSnapshot.hasError) {
                                  return const SizedBox.shrink(); // Skip on error
                                } else {
                                  String? status = statusSnapshot.data;

                                  if (status != null) {
                                    return AppliedJobWidget(
                                      selType: status,
                                      jobData: job,
                                    );
                                  } else {
                                    return const SizedBox.shrink(); // Skip if no status
                                  }
                                }
                              },
                            ),
                          );
                        }

                        // Remove empty widgets and display only valid applied jobs
                        return Column(
                          children: appliedJobWidgets.where((widget) => widget is! SizedBox).toList(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
