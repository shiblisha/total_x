import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:flutter/material.dart';

import 'otp.dart';

class Signup_number extends StatefulWidget {
  const Signup_number({Key? key}) : super(key: key);

  @override
  State<Signup_number> createState() => _Signup_numberState();
}
FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController phone=TextEditingController();
class _Signup_numberState extends State<Signup_number> {
  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return Scaffold(resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
              padding:  EdgeInsets.only(left: mwidth*0.05),
              child: Text("Enter Your\nMobile Number",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,color: Color(0xff004B59)),),
            ),
            SizedBox(
              height: mheight*0.1,
            ),
            Padding(
                padding: EdgeInsets.only(left: mwidth * 0.08),
                child: Container(
                  height: mheight * 0.08,
                  width: mwidth * 0.80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: Row(
                      children: [
                        Container(
                            height: mheight * 0.05,
                            width: mwidth * 0.60,
                            child: Padding(
                                padding: EdgeInsets.only(left: mwidth * 0.02),
                                child: TextFormField(controller: phone,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      hintText: 'Enter Phone Number',
                                      hintStyle: TextStyle(color: Color(0xff90A4AE))),
                                )
                            )
                        )
                      ]),
                )
            ),
            SizedBox(
              height: mheight * .03,
            ),
            SizedBox(
              width: mwidth * .3,
            ),
            Center(
              child: Container(
                  height: mheight * .05,
                  width: mwidth * .7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color:Color(0xff004B59)),
                  child: TextButton(
                      child: Text(
                        'Get otp',

                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: (){
                        auth.verifyPhoneNumber(phoneNumber: phone.text,verificationCompleted: (_){},
                            verificationFailed: (e){
                              ToastMessage().toastmessage(message: e.toString());
                            },
                            codeSent: (String verificationId,int? token){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (ctx) => Otp_form(verificationId: verificationId,)));


                            },
                            codeAutoRetrievalTimeout: (e){
                              ToastMessage().toastmessage(message: e.toString());
                            });
                      })),
            ),
          ]),
        ));
  }
}
