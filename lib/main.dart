import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustlehub/firebase_options.dart';
import 'package:hustlehub/routes/routes.dart';
import 'package:hustlehub/services/appliedJobsDatabase.dart';
import 'package:hustlehub/services/local_database.dart';
import 'package:hustlehub/services/userDataBase.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
LocalDatabse ldb = LocalDatabse();
AppliedJobsDatabase ajdb = AppliedJobsDatabase();
UserDataBase udb = UserDataBase();
await ldb.initializeDb();
await ajdb.initializeDb();
await udb.initializeDb();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
      designSize: const Size( 393,852 ),

      //for font .sp
      //container width and height  .w and .h
       minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        onGenerateRoute: (settings) => generateRoute(settings),
        initialRoute: '/',
        // home:  const AuthCheck(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
      
          fontFamily: 'SFProDisplay',
         
        ),
      ),
    );
  }
}
