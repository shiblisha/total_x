import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:flutter/material.dart';
import 'otp.dart';


class Phonelogin extends StatelessWidget {
  Phonelogin({Key? key}) : super(key: key);
  TextEditingController phone = TextEditingController();

  String phone1='';
  final form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    FirebaseAuth auth = FirebaseAuth.instance;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF5F5F5),
      body: Form(
        key: form_key,
        child: Column(
          children: [
            SizedBox(
              height: mheight * 0.42,
            ),
            Center(
              child: Card(
                elevation: 2.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: mwidth * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: mwidth * 0.9,
                  height: mheight * 0.07,
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: mwidth * 0.05),
                          child: Text("+91")
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.004),
                        width: mwidth * 0.756,
                        height: mheight * 0.08,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: phone,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty||value.length<10) {
                              return 'Invaild Phone Number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            phone1 = value!;
                          },
                          decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintText: 'Enter Your Phone Number',
                              hintStyle: TextStyle(
                                  color: Color(0xff7DAEB8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'title')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mheight * 0.012,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  final isvalid = form_key.currentState?.validate();
                  if (isvalid == true) {
                    form_key.currentState?.save();
                    auth.verifyPhoneNumber(phoneNumber:"+91${phone.text}",verificationCompleted: (_){},
                        verificationFailed: (e){
                          ToastMessage().toastmessage(message: e.toString());
                        },
                        codeSent: (String verificationId,int? token){
                          Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>Ottplatform(verifivationId: verificationId,)));


                        },
                        codeAutoRetrievalTimeout: (e){
                          ToastMessage().toastmessage(message: e.toString());
                        });

                  }},
                child:Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff0E697C),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  width: mwidth * 0.32,
                  height: mheight * 0.05,
                  child: const Center(
                    child: Text(
                      'Get Otp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'title',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}