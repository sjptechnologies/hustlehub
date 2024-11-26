import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hustlehub/company/widgets/selTypeButtonWidget.dart';
import 'package:hustlehub/users/widgets/recommandationJobsWidget.dart';
import 'package:hustlehub/utils/constants.dart';
import 'package:hustlehub/utils/controller.dart';

import 'package:path_provider/path_provider.dart';

class SingleApplicationScreen extends StatefulWidget {
  Map<String, dynamic> applicantDetails;
  SingleApplicationScreen({super.key, required this.applicantDetails});

  @override
  State<SingleApplicationScreen> createState() =>
      _SingleApplicationScreenState();
}

class _SingleApplicationScreenState extends State<SingleApplicationScreen> {
  String? _localFilePath; // Local file path for the downloaded PDF
  bool _isDownloading = true; // State to show progress

  @override
  void initState() {
    super.initState();
    _downloadAndSavePDF(widget.applicantDetails['resumeUrl']);
  }

  // Download PDF and save to local storage
  Future<void> _downloadAndSavePDF(String url) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/resume.pdf';

      await Dio().download(url, filePath);

      setState(() {
        _localFilePath = filePath;
        _isDownloading = false;
      });
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });
      debugPrint('Error downloading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.applicantDetails['name'];
    String email = widget.applicantDetails['email'];
    String phone = widget.applicantDetails['phone'];
    String indroduction = widget.applicantDetails['indroduction'];
    String docId = widget.applicantDetails['docId'];
    String jobId = widget.applicantDetails['jobId'];

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kBgColor,
      ),
      backgroundColor: kBgColor,
      body: _isDownloading
          ? const Center(child: CircularProgressIndicator()) // Show loader
          : _localFilePath == null
              ? const Center(child: Text("Failed to load PDF"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecommandationJobsWidget(value: name, title: 'Name'),
                      const Divider(height: 20),
                      RecommandationJobsWidget(value: email, title: 'Email'),
                      const Divider(height: 20),
                      RecommandationJobsWidget(value: phone, title: 'Phone No'),
                      const Divider(height: 20),
                      RecommandationJobsWidget(
                          value: indroduction, title: 'Introduction'),
                      const Divider(height: 20),
                      const Text(
                        'Resume:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 400,
                        child: PDFView(
                          filePath: _localFilePath!,
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: false,
                          pageFling: false,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                try {
                                  await updateStatus(
                                      name: name,
                                      email: email,
                                      phno: phone,
                                      status: 'approved',
                                      companyId: docId,
                                      jobId: jobId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Approval Successfull')));
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              },
                              child: SelTypeButtonWidget(
                                color: Colors.green,
                                selType: 'Approve',
                              )),
                          GestureDetector(
                            onTap: () async {
                                try {
                                  await updateStatus(
                                      name: name,
                                      email: email,
                                      phno: phone,
                                      status: 'rejected',
                                      companyId: docId,
                                      jobId: jobId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Rejection Successfull')));
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              },
                              child: SelTypeButtonWidget(
                            color: Colors.red,
                            selType: 'Reject',
                          )),
                          GestureDetector(
                            onTap: () async {
                                try {
                                  await updateStatus(
                                      name: name,
                                      email: email,
                                      phno: phone,
                                      status: 'reviewed',
                                      companyId: docId,
                                      jobId: jobId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Reviewal  Successfull')));
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              },
                              child: SelTypeButtonWidget(
                            color: Colors.blueAccent.shade700,
                            selType: 'Review',
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                                try {
                                  await updateStatus(
                                      name: name,
                                      email: email,
                                      phno: phone,
                                      status: 'in review',
                                      companyId: docId,
                                      jobId: jobId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('In Review Successfull')));
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              },
                              child: SelTypeButtonWidget(
                            color: Colors.yellow.shade700,
                            selType: 'In Review',
                          )),
                          GestureDetector(
                            onTap: () async {
                                try {
                                  await updateStatus(
                                      name: name,
                                      email: email,
                                      phno: phone,
                                      status: 'short listed',
                                      companyId: docId,
                                      jobId: jobId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Data Short Listed')));
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              },
                              child: SelTypeButtonWidget(
                            color: Colors.lightBlue.shade800,
                            selType: 'Short Listed',
                          ))
                        ],
                      )
                    ],
                  ),
                ),
    ));
  }
}
