import 'dart:convert';

import 'package:dealsdray/auth/auth_controller.dart';
import 'package:dealsdray/auth/verify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final List<bool> _isSelected = [true,false];
  String userName = "phone number";
  String labelText = "Phone";
  late final String response;

  @override
  void initState() {
    setState(() {
      getPhone();
    });
    super.initState();
  }

  void getPhone() async{
    controller.userNameController.text = await fetchPhone();
  }

  Future<String> fetchPhone() async{
    try{
      final res = await http.get(Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp'));
      if(res.statusCode == 200){
        final data = jsonDecode(res.body);
        if(data['cod'] == 200 && data.containsKey('mobileNumber')){
          response = data['mobileNumber'];
        }else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error fetching Phone")),);
        }
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${res.statusCode} - ${res.reasonPhrase}")),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e.toString());
    }
    return response;
  }

  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Logo image (replace with your logo)
              Image.asset('assets/images/brandLogo.png', height: 80,fit: BoxFit.cover,),
              const SizedBox(height: 20),
              // Toggle between Phone and Email
              ToggleButtons(
                isSelected: _isSelected,
                selectedColor: Colors.white,
                fillColor: Colors.red,
                borderColor: Colors.grey,
                borderRadius: BorderRadius.circular(8),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Phone'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Email'),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _isSelected.length; i++) {
                      _isSelected[i] = i == index;
                    }
                    if(_isSelected[0] == true){
                      userName = "phone number";
                      labelText = "Phone";
                    }
                    if(_isSelected[1] == true){
                      userName = "email";
                      labelText = "Email";
                    }
                  });
                },
              ),
              const SizedBox(height: 40),
              const Text(
                "Glad to see you!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Please provide your $userName",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              // Phone or Email input field
              TextFormField(
                controller: controller.userNameController,
                decoration: InputDecoration(
                  labelText: labelText,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              // Send Code Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    if(controller.userNameController.text.toString().isNotEmpty){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Verify()));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill all details")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SEND CODE',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
