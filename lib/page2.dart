import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_aurth/logged_in_page.dart';
import 'package:phone_aurth/main.dart';

var user_data;


class EnterOtp extends StatefulWidget {
  const EnterOtp({Key? key}) : super(key: key);

  @override
  State<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  var code;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              maxLength: 6,
              onChanged: (value) {
                code = value;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  helperText: 'Enter OTP',
                  border: OutlineInputBorder()),
            ),
          ),




Container(
    child: ElevatedButton(
    onPressed: () async {
    try{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyApp.verify, smsCode: code);
    // Sign the user in (or link) with the credential
     user_data=await auth.signInWithCredential(credential);
    print("dddddddddddddddddddddddddddddddddd");
    print(user_data);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoggedInPage()));

    }
    catch(e){
    Fluttertoast.showToast(msg: "Entered OTP is Invalid",backgroundColor: Colors.red,);
    print("WRONG OTP");
    }
    },
    child: Text("Verify OTP"),
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
    Colors.blue.shade300),
    ),
    ),
    ),
        ],
      ),
    );
  }
}
