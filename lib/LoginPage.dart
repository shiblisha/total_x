import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/home.dart';
import 'package:firebase_project/phone_number.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'signup.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$";
String loginpage_email1 = '';
String loginpage_password1 = '';
bool passwordvisible = false;
class _LoginPageState extends State<LoginPage> {
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
      return await auth.signInWithCredential(credential).then((value) =>   Navigator.of(context).push(
          MaterialPageRoute(
              builder: (ctx) => Home()))).onError((error, stackTrace) => ToastMessage()
          .toastmessage(message: error.toString()));
    } catch (e) {
      //show error toast message here
      log('\n_signInWithGoogle: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(pattern);
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    return Scaffold(resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Padding(
          padding: EdgeInsets.only(left: mwidth * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mheight * 0.01,
              ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.05),
                child: Text(
                  "Hello!\nWelcome back",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Color(0xff004B59)),
                ),
              ),
              SizedBox(
                height: mheight * 0.08,
              ),
              Center(
                child: Card(
                    child: Container(
                  height: mheight * 0.05,
                  width: mwidth * 0.80,
                  child: Row(children: [
                    Container(
                      height: mheight * 0.05,
                      width: mwidth * 0.60,
                      child: Padding(
                        padding: EdgeInsets.only(left: mwidth * 0.02),
                        child: TextFormField(
                          controller: email,
                          onSaved: (value) {
                            loginpage_email1 = value!;
                            loginpage_email1 = value!.trim();
                            value.replaceAll(RegExp(r'\s+'), '');
                          },onChanged: (value) {

                          email.value = TextEditingValue(
                            text: value.trim(),
                            selection:  email.selection,
                          );
                        },

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !regex.hasMatch(value)) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Color(0xff90A4AE))),

                        ),
                      ),
                    ),
                  ]),
                )),
              ),
              SizedBox(
                height: mheight * .03,
              ),
              Center(
                child: Card(
                    child: Container(
                  height: mheight * 0.05,
                  width: mwidth * 0.80,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    Container(
                      height: mheight * 0.05,
                      width: mwidth * 0.8,
                      child: Padding(
                        padding: EdgeInsets.only(left: mwidth * 0.02),
                        child: TextFormField(
                          controller: password,
                          obscureText: passwordvisible ? false : true,

                          validator: (value) {
                            if (value == null ||
                                value.length < 6 ||
                                value.isEmpty) {
                              return 'Password should be atleast 6 character';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            loginpage_password1 = value!;
                          },
                          decoration: InputDecoration(
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordvisible = !passwordvisible;
                                  });
                                },
                                icon: passwordvisible
                                    ? Icon(
                                  Icons.remove_red_eye,
                                  color: Color(0xff95BDC6),
                                  size: size.width*0.04,
                                )
                                    : Icon(
                                  FontAwesomeIcons.eyeSlash,
                                  color: Color(0xff95BDC6),
                                  size: 14,
                                )),

                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintText: 'password',
                              hintStyle: TextStyle(color: Color(0xff90A4AE))),
                        ),
                      ),
                    ),
                    ]),
                )),
              ),
              SizedBox(
                height: mheight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: mwidth * 0.6),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(color: Color(0xff004B59)),
                    )),
              ),
              SizedBox(
                height: mheight * 0.02,
              ),
              Center(
                child: Container(
                  height: mheight * 0.06,
                  width: mwidth * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff004B59)),
                  child: TextButton(
                    onPressed: () {
                      auth
                          .signInWithEmailAndPassword(
                              email: email.text, password: password.text)
                          .then((value) => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => Home())),
                                ToastMessage().toastmessage(
                                    message: 'Successfully Logined')
                              })
                          .onError((error, stackTrace) => ToastMessage()
                              .toastmessage(message: error.toString()));
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mheight * .025,
              ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.25),
                child: Row(children: [
                  Text(
                    "Dont have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.grey),
                  ),
                 TextButton(onPressed: (){ Navigator.of(context).push(MaterialPageRoute(
                     builder: (ctx) => Sign_up()));}, child:  Text(" Sign Up" ,style: TextStyle( fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xff004B59)),))
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
                GestureDetector(onTap: (){_signInWithGoogle();},
                  child: SizedBox(
                    height: mheight*0.05,width: mwidth*0.2,
                      child: Image.asset("assets/google.png")),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: mheight*0.01,left: mwidth*0.1),
                  child: GestureDetector(onTap: (){ Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => Phonelogin()));},
                    child: SizedBox(
                    height: mheight*0.04,width: mwidth*0.2,
                        child: Image.asset("assets/mobile.png")),
                  ),
                ),

              ],)
            ],
          ),
        ),
      ),
    );
  }
}
