import 'package:dealsdray/auth/auth_controller.dart';
import 'package:dealsdray/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

  var controller = Get.put(AuthController());
  late final String _resCheck;
  int count = 30;

  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();

  @override
  void initState() {
    changeTimer();
    fetchOTP();
    super.initState();
  }


  void changeTimer(){
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        if(count>0){
          count--;
          changeTimer();
        }
      });
    });
  }

  void fetchOTP() async{
    _resCheck = await controller.fetchData(context: context);
    if(_resCheck.isNotEmpty && _resCheck.length >= 4){
      setState(() {
        otpController1.text = _resCheck[0];
        otpController2.text = _resCheck[1];
        otpController3.text = _resCheck[2];
        otpController4.text = _resCheck[3];
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid OTP received")));
    }
  }

  @override
  Widget build(BuildContext context) {

    String inputCheck = controller.validateInput(controller.userNameController.text.toString());
    String input = inputCheck=="Email Detected" ? "email" : inputCheck=="Phone Number Detected"? "mobile": "invalid";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/otp.png', // Replace with your image asset
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "We have sent a unique OTP number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                "to your $input ${controller.userNameController.text.toString()}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  otpBox(controller: otpController1),
                  otpBox(controller: otpController2),
                  otpBox(controller: otpController3),
                  otpBox(controller: otpController4),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$count seconds",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        count = 30;
                        changeTimer();
                      });
                    },
                    child: Text(
                      "SEND AGAIN",
                      style: TextStyle(
                        color: count==0 ? Colors.red : Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'VERIFY',
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

Widget otpBox({controller}) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
      ),
    ),
  );
}

