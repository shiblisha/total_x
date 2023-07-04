import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/phone_number.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:firebase_project/upload_image.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
import 'home.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}
FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController username = TextEditingController();
class _Sign_upState extends State<Sign_up> {
  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                foregroundImage: AssetImage('assets/company icons.jpg'),
              ),
            ),
            SizedBox(
              height: mheight*0.05,
            ),
            Text("welcome Back,",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.red),),
            Text("Please sign in to continue",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,),),
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
                              child: TextFormField(controller: username,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintText: 'Enter Your username',
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
              height: mheight * .03,
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
              height: mheight * .03,
            ),
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
              height: mheight * .03,
            ),
            Container(
              height: mheight * 0.06,
              width: mwidth * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red),
              child:TextButton(
                onPressed: () {
                  auth
                      .createUserWithEmailAndPassword(
                      email: email.text, password: password.text)
                      .then((value) => {

                        Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>Upload_image())),
                    ToastMessage().toastmessage(message: 'Successfully registerd')
                  })
                      .onError((error, stackTrace) => ToastMessage()
                      .toastmessage(message: error.toString()));
                },
                child: Text ('Sgin Up',style: TextStyle(color: Colors.black,
                  fontSize: 15,fontWeight: FontWeight.w900

                ),),
              ),
            ),
            SizedBox(
              height: mheight * .05,
            ),
            Row(
              children: [SizedBox(width: mwidth*.05,),
                Container( height: mheight * .05,
                  width: mwidth * .3,decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red),
                 child: TextButton(child: Text('go to login',style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold,color: Colors.black)),onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>Login())))),
                SizedBox(width: mwidth*.3,),
                Container( height: mheight * .05,
                  width: mwidth * .3,decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red),
                  child: TextButton(child: Text('Sign with number',style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold,color: Colors.black),),onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>Signup_number())))),]
            ),


          ],
        ),
      ),
    );
  }
}
