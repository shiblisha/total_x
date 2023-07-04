import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:flutter/material.dart';

class Forgot_password extends StatefulWidget {
  const Forgot_password({Key? key}) : super(key: key);

  @override
  State<Forgot_password> createState() => _Forgot_passwordState();
}

TextEditingController email = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _Forgot_passwordState extends State<Forgot_password> {
  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery
        .of(context)
        .size
        .height;
    var mwidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: mwidth*0.08),
              child: Card(
                  child: Container(
                    height: mheight*0.05,
                    width: mwidth*0.80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:Row(
                        children: [
                          Container(
                            height: mheight*0.05,
                            width: mwidth*0.60,
                            child: Padding(
                              padding:  EdgeInsets.only(left: mwidth*0.02),
                              child: TextFormField(controller: email,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintText: 'Enter Your Email Adderss',
                                    hintStyle: TextStyle(color: Color(0xff90A4AE))
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                height: mheight * .05,
                width: mwidth * .3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red),
                child: TextButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  onPressed: () {
                    auth.sendPasswordResetEmail(email: email.text).then((
                        value) =>
                        ToastMessage().toastmessage(
                            message: 'PAssword changed succefully')).onError((
                        error, stackTrace) =>
                        ToastMessage().toastmessage(message: error.toString())
                        );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
