import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:phone_aurth/page2.dart';

void main()async
{
  await  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(home:MyApp(),
  debugShowCheckedModeBanner: false,));
}

var phone;
TextEditingController number=TextEditingController();


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
static String verify='';
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Phone Number Verification"),
        centerTitle: true,
      ),

      backgroundColor: Colors.red,
      body: Column(
        children: [
          SizedBox(height:MediaQuery.of(context).size.height/3.5),

          Text("Enter Phone Number",style: TextStyle(color: Colors.orange,fontSize: 30),),
          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
            child: TextFormField(
              controller: number,
              decoration: InputDecoration(border: OutlineInputBorder()),keyboardType:TextInputType.phone,
              onChanged: (value){
                setState(() {
                  phone=value;
                });
              },
            ),

          ),


          Container(
            child: ElevatedButton(
              onPressed: () async {Navigator.push(context,MaterialPageRoute(builder: (context)=>EnterOtp()));

                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '${phone}',
                  verificationCompleted: (PhoneAuthCredential credential) {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>EnterOtp()));
                  },
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    MyApp.verify = verificationId;
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: Text("Get OTP"),
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
