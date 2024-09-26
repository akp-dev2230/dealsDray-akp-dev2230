import 'package:dealsdray/auth/auth_controller.dart';
import 'package:dealsdray/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  bool _obscurePassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  var controller = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Center(
              child: Image.asset('assets/images/brandLogo.png', height: 100,),
            ),
            const SizedBox(height: 20),

            // Heading Text
            const Text("Let's Begin!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 10),

            // Subtext
            const Text("Please enter your credentials to proceed", style: TextStyle(fontSize: 16, color: Colors.grey,),),
            const SizedBox(height: 40),

            // Email Field
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Your Email',
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Password Field with visibility toggle
            TextField(
              controller: passController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Create Password',
                border: const UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Referral Code Field (Optional)
            const TextField(
              decoration: InputDecoration(
                labelText: 'Referral Code (Optional)',
                border: UnderlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      // Floating action button for submission
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          if(emailController.text.toString().isNotEmpty && passController.text.toString().isNotEmpty){
            try{
              await controller.signupMethod(
                email: emailController.text,
                password: passController.text,
              ).then((value){
                VxToast.show(context, msg: "Sign up completed");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainScreen()));
              });
            }catch (e){
              VxToast.show(context, msg: e.toString());
            }
          }
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
