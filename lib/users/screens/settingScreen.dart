import 'package:flutter/material.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/utils/constants.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
       
        backgroundColor: kBgColor,
      ),
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0,left:15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Settings",
                  style: TextStyle(
                      color: kfontColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),),
                      ksizedBoxHeight,
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.personalInfoScreen);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.account_circle_outlined,size: 24,),
                            widthInRow,
                            Text("Personal info",style: TextStyle(
                              color: kfontColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),)
                          ],
                        ),
                      ),
                      kheightinRec,
                      kheightinRec,
                      const Row(
                        children: [
                          Icon(Icons.notifications_outlined,size: 24,),
                          widthInRow,
                          Text("Notifications",style: TextStyle(
                            color: kfontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),)
                        ],
                      ),
                       kheightinRec,
                       kheightinRec,
                      const Row(
                        children: [
                          Icon(Icons.help_outline,size: 24,),
                          widthInRow,
                          Text("Help",style: TextStyle(
                            color: kfontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),)
                        ],
                      ),
                       kheightinRec,
                       kheightinRec,
                      const Row(
                        children: [
                          Icon(Icons.privacy_tip_outlined,size: 24,),
                          widthInRow,
                          Text("privacy Policy",style: TextStyle(
                            color: kfontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),)
                        ],
                      ),
                       kheightinRec,
                       kheightinRec,
                      const Row(
                        children: [
                          Icon(Icons.accessibility,size: 24,),
                          widthInRow,
                          Text("Accessebility",style: TextStyle(
                            color: kfontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),)
                        ],
                      ),
                      
            ],
          ),
        ),
      ),
    ));
  }
}