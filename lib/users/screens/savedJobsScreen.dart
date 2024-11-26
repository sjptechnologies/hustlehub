import 'package:flutter/material.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/services/local_database.dart';
import 'package:hustlehub/users/widgets/savedJobWidget.dart';
import 'package:hustlehub/utils/constants.dart';


class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({super.key});

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  LocalDatabse ldb = LocalDatabse();

Future<void> _refreshSavedJobs() async {
    setState(() {}); // Trigger a rebuild to fetch the latest data
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text("Saved Jobs"),
          leading: IconButton(icon:const Icon(Icons.chevron_left),onPressed: (){
            Navigator.pop(context);
          },),
          backgroundColor: kBgColor,
      ),
      backgroundColor: kBgColor,
      body: Padding(padding: EdgeInsets.all(10),
      child: FutureBuilder(
                  future: ldb.retrieveValue(),
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
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                          context, AppRoute.jobDetailScreen,
                                          arguments: snapshot.data![index])
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: SavedJobWidget(
                                  jobDetails: snapshot.data![index],
                                  index: index,
                                   onJobChanged: _refreshSavedJobs,
                                ));
                          },
                        ),
                      );
                    }
                  },
                )
      ),
    ));
  }
}