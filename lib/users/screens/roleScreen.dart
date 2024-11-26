import 'package:flutter/material.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/utils/constants.dart';


// ignore: must_be_immutable
class RoleScreen extends StatefulWidget {
  Map<String,dynamic>? user;
  RoleScreen({super.key,this.user});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}




class _RoleScreenState extends State<RoleScreen> {
  
// ignore: prefer_final_fields
TextEditingController _roleController =TextEditingController();
String? selectedRole;



  bool get _isButtonEnabled {
    return _roleController.text.isNotEmpty;
  }

  Map<String,dynamic>? userData;
  List<String> roles = ["Flutter Developer", "UI/UX Designer", "Manager", "Marketer"];
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        ),
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Your Role",
                style: TextStyle(
                    color: kfontColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              kheightinRec,
              const Text(
                "Please enter your role",
                style: TextStyle(
                  color: ktextColor,
                  fontSize: 15,
                ),
              ),
              const Text(
                "Learn more",
                style: TextStyle(
                  color: kshowAllColor,
                  fontSize: 15,
                ),
              ),
              ksizedBoxHeight,
              Material(
                color: kcontainerColor,
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  readOnly: true,
                  controller: _roleController,
                  decoration: InputDecoration(
                    suffixIcon: PopupMenuButton<String>(
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (String value) {
                        _roleController.text = value;
                        setState(() {});
                      },
                      itemBuilder: (BuildContext context) {
                        return roles.map<PopupMenuItem<String>>((String value) {
                          return PopupMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList();
                      },
                    ),
                    hintText: "Select Your Role",
                    hintStyle: const TextStyle(color: ktextColor),

                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    border: InputBorder.none, // Removes the default border
                  ),
                ),
              ),
              kheightinRec,
              kheightinRec,
             
            
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      if(_isButtonEnabled){
                        userData ={
                          'name':widget.user?['name'],
                          'email':widget.user?['email'],
                          'role':_roleController.text,
                         
                        };
                        // print('---------------------------------');
                        // print(userData);
                        // print('-------------------------------------------');
                      Navigator.pushReplacementNamed(
                          context,
                          AppRoute.securityCheckScreen,arguments: userData);
                      }
                      else{
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You should fill the fields')));
                      }
                    },
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 13)),
                      backgroundColor: WidgetStatePropertyAll(
                          _isButtonEnabled ? Colors.black : ktextColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Set border radius
                        ),
                      ),
                    ),
                    child: const Text(
                      "Submit",
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
