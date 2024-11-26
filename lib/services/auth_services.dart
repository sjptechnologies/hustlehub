
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthServices {


  Future<void> registration(String email,String password) async{
    try{

     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

    }
    catch (e){
      rethrow;
    }
  }

  Future<String> login(String email,String password) async{
    try{
       UserCredential user =   await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
       return user.user!.uid;
    }
    catch(e){
      rethrow;
    }
  }


String? getUser(){
  return   FirebaseAuth.instance.currentUser?.uid;
  }




  

  
}
