// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustlehub/utils/constants.dart';

import '../../company/models/companyModel.dart';
import '../../routes/routeConstants.dart';
import '../../services/auth_services.dart';
import '../../services/firestoreDataBase.dart';
import '../widgets/loginTextFieldWidget.dart';
import '../widgets/socialMediaWidget.dart';

class LoginScreen extends StatefulWidget {
  String? title;
  LoginScreen({super.key, this.title});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool login = true;
  bool register = false;
  bool _value = false;
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  bool get _isButtonEnabled {
    if (login) {
      return _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    } else {
      return _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _value;
    }
  }

  AuthServices authServices = AuthServices();
  FirestoreServices firestoreServices = FirestoreServices();

  Map<String, dynamic>? userData;

  void signupuiHandler(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      await authServices.registration(
          _emailController.text, _passwordController.text);
      userData = {'name': _nameController.text, 'email': _emailController.text};
      // print(userData);
      // await firestoreServices.storeData(_nameController.text, _emailController.text);
      setState(() {
        isLoading = false;
      });
      if (widget.title == 'jobseeker') {
        Navigator.pushReplacementNamed(
            context,
            AppRoute.roleScreen,arguments: userData);
      } else if (widget.title == 'company') {
        firestoreServices.storeCompanyData(CompanyModel(
            company: _nameController.text, email: _emailController.text));
        Navigator.pushReplacementNamed(context,
           AppRoute.companyHomeScreen);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void loginUiHandler(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final uid = await authServices.login(
          _emailController.text, _passwordController.text);

      final userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (userSnapshot.exists) {
        Navigator.pushReplacementNamed(
          context,
          AppRoute.rootScreen, // Navigate to RootScreen for users
        );
      } else {
         final companySnapshot =
          await FirebaseFirestore.instance.collection('Companies').doc(uid).get();

      if (companySnapshot.exists){
        Navigator.pushReplacementNamed(
          context,
          AppRoute.companyHomeScreen
         // Navigate to HomeScreen for companies
        );
      }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
          padding: const EdgeInsets.all(45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ksizedBoxHeight,
               Text(
                "Welcome",
                style: TextStyle(
                    color: kfontColor,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
              ),
              kheightinRec,
              const Text(
                "Log in with your account or with your social media",
                style: TextStyle(
                    color: ktextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              ksizedBoxHeight,
              Stack(children: [
                // Full-width line with height 1
                Positioned(
                  top: 34,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: kfontColor,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          login = true;
                          register = false;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                color: login ? kfontColor : ktextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          kheightinRec,
                          Container(
                            height: login
                                ? 2
                                : 0, // Change height based on selection
                            width: 50, // Width of the underline under "Login"
                            color: kfontColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          login = false;
                          register = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "Register",
                            style: TextStyle(
                                color: register ? kfontColor : ktextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          kheightinRec,
                          Container(
                            height: register
                                ? 2
                                : 0, // Change height based on selection
                            width:
                                70, // Width of the underline under "Register"
                            color: kfontColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ]),
              kheightinRec,
              kheightinRec,
              Visibility(
                  visible: register,
                  child: Column(
                    children: [
                      LoginTextFieldWidget(
                          text: "Name",
                          obscure: false,
                          controller: _nameController),
                      kheightinRec,
                      kheightinRec
                    ],
                  )),
              LoginTextFieldWidget(
                text: "Email",
                obscure: false,
                controller: _emailController,
              ),
              kheightinRec,
              kheightinRec,
              LoginTextFieldWidget(
                text: "Password",
                obscure: true,
                controller: _passwordController,
              ),
              kheightinRec,
              // kheightinRec,
              Visibility(
                  visible: register,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Aligns the checkbox to the top
                    children: [
                      Checkbox(
                        value: _value,
                        checkColor: Colors.white,
                        activeColor: kshowAllColor,
                        materialTapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Removes extra margin around the checkbox
                        onChanged: (bool? value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text(
                          "I confirm that I am of legal age, I have read and agree to the Service agreement.",
                          style: TextStyle(
                            color: ktextColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  )),
              kheightinRec,

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    if (_isButtonEnabled) {
                      if (register) {
                        signupuiHandler(context);
                      } else if (login) {
                        loginUiHandler(context);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('You should give the email and password')));
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
                  child: isLoading
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        ) // Loading indicator when isLoading is true
                      : Text(
                          login ? "Login" : "Register",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
              kheightinRec,
              kheightinRec,
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Divider(
                      color: kfontColor, // Line color
                      thickness: 1, // Line thickness
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      login
                          ? "or login with"
                          : "or register with", // Your text in the middle
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: kfontColor, // Line color
                      thickness: 1, // Line thickness
                    ),
                  ),
                ],
              ),
              ksizedBoxHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialMediaWidget(
                    image: Image.asset(
                      'assets/images/google.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SocialMediaWidget(
                    image: Image.asset(
                      'assets/images/apple.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SocialMediaWidget(
                    image: Image.asset(
                      'assets/images/facebook.png',
                      width: 25,
                      height: 25,
                    ),
                  )
                ],
              ),
              ksizedBoxHeight,
              Visibility(
                visible: login,
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: kshowAllColor),
                          )),
                    ),
                    const Divider(
                      indent: 98,
                      endIndent: 98,
                      height: 5,
                      color: kshowAllColor,
                      thickness: 1.5,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
