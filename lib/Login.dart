import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/forgot_password.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:firebase_project/upload_image.dart';
import 'package:flutter/material.dart';

import 'firestore.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return Scaffold(resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: mheight * .03),
          child: Column(
            children: [
              SizedBox(
                  height: mheight*0.1
              ),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  foregroundImage: AssetImage('assets/company icons.jpg'),
                ),
              ),
              SizedBox(
                height: mheight*0.08,
              ),
              Text("Hello GUYS,",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.red),),
              SizedBox(
                height: mheight*0.08,
              ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.04),
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
                height: mheight * .05,
              ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.04),
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
                                padding: EdgeInsets.only(left: mwidth*0.02),
                                child: TextFormField(controller: password,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      hintText: 'Enter Your password',
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
                height: mheight*0.01,
                width: mwidth*0.3,
              ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.35),
                child: TextButton(
                    child: Text(
                      'Forgott password',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) =>Forgot_password()))),
              ),
              SizedBox(
                height: mheight * .05,
              ),
              Center(
                child: Container(
                  height: mheight * .05,
                  width: mwidth * .3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red),
                  child: TextButton(
                    onPressed: () {
                      auth
                          .signInWithEmailAndPassword(
                              email: email.text, password: password.text)
                          .then((value) => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext a) => Upload_image())),
                                ToastMessage().toastmessage(message: 'welcome')
                              })
                          .onError((error, stackTrace) => ToastMessage()
                              .toastmessage(message: error.toString()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
