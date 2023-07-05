import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/forgot_password.dart';
import 'package:firebase_project/phone_number.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'LoginPage.dart';
import 'home.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;
bool isLoading = false;

class _Sign_upState extends State<Sign_up> {
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await auth.signInWithCredential(credential);
    } catch (e) {
      //show error toast message here
      log('\n_signInWithGoogle: $e');
      return null;
    }
  }

  Future<User?> createAccount(
     String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;



    try {
      UserCredential userCrendetial = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      ToastMessage().toastmessage(message: 'Successfully Registered');
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const Home()),
      );

    } catch (error) {
      ToastMessage().toastmessage(message: error.toString());
    } finally {
      setState(() {
        isLoading = false; // Hide progress indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return Scaffold(resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: mheight * .03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: mheight*0.05
              ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.05),
                child: Text("Signup to\nGet Started ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Color(0xff004B59)),),
              ),
              SizedBox(
                height: mheight*0.08,
              ),
              Center(
                child: Card(elevation: 2,
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
                                      hintText: 'Email ',
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
                height: mheight * 0.02,
              ),
              Center(
                child: Card(elevation: 2,
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
                                      hintText: 'Password',
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
              Center(
                child: Container(
                  height: mheight * .05,
                  width: mwidth * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff004B59)),
                  child: TextButton(
                    onPressed: () {
                      createAccount(email.text, password.text);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.25),
                child: Row(children: [
                  Text(
                    "Already have an account",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                  TextButton(onPressed: (){ Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => LoginPage()));}, child:  Text(" Sign in" ,style: TextStyle( fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xff004B59)),))
                ]),
              ),
              SizedBox(height: mheight*0.05,),
              Center(
                child: SizedBox(
                    width :mwidth*0.8,
                    child: Divider(height: mheight*0.05,thickness: 2,)),
              ),
              SizedBox(height: mheight*0.04,),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: mwidth*0.2,),
                  GestureDetector(onTap: (){_signInWithGoogle() .then((value) {


                    print(value);
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => Home()));})
                      .onError((error, stackTrace) => ToastMessage()
                      .toastmessage(message: error.toString()));},
                    child: SizedBox(
                        height: mheight*0.05,width: mwidth*0.2,
                        child: Image.asset("assets/google.png")),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: mheight*0.01,left: mwidth*0.1),
                    child: GestureDetector(onTap: (){ Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => Signup_number()));},
                      child: SizedBox(
                          height: mheight*0.04,width: mwidth*0.2,
                          child: Image.asset("assets/mobile.png")),
                    ),
                  ),

                ],)
            ],
          ),
        ));
  }
}
