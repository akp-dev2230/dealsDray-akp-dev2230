import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController{

  TextEditingController userNameController = TextEditingController();
  String response = '';
  late String otpCheck;

  String validateInput(String input) {
    // Regular expression for email validation
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegex = RegExp(emailPattern);

    // Regular expression for phone validation (10 digits)
    String phonePattern = r'^\d{10}$';
    RegExp phoneRegex = RegExp(phonePattern);

    // Check if input is email
    if (emailRegex.hasMatch(input)) {
      return "Email Detected";
    }
    // Check if input is phone number
    else if (phoneRegex.hasMatch(input)) {
      return "Phone Number Detected";
    }
    // If neither, return invalid input
    else {
      return "Invalid input";
    }
  }

  Future<String> fetchData({context}) async{
    try{
      final res = await http.get(Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp/verification'));
      final data = jsonDecode(res.body);
      if(data['cod'] == 200){
        response = data['otp'];
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return response;
  }


  //signup method
  Future<UserCredential?> signupMethod({email, password, context}) async{
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      await storeUserData(email: email, password: password);
    } on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }


  //storing data
  Future<void> storeUserData({email, password}) async{
    DocumentReference store = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    await store.set({
      'email': email,
      'password': password,
    });
  }


}