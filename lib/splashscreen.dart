import 'package:dealsdray/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Image(image: AssetImage("assets/images/internBg.jpg"), fit: BoxFit.fill,),
          Positioned(
            top: context.screenHeight/2,
            right: context.screenWidth/2,
            child: const CircularProgressIndicator(color: Colors.red,),
          ),
        ],
      ),
    );
  }
}
