import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/home.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:flutter/material.dart';

class Ottplatform extends StatefulWidget {
  final verifivationId;
  Ottplatform({Key? key,required this.verifivationId}) : super(key: key);

  @override
  State<Ottplatform> createState() => _OttplatformState();
}

class _OttplatformState extends State<Ottplatform> {
  TextEditingController Ottp = TextEditingController();

  String Ottp1 ='';

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
                  child: Container(
                    padding: EdgeInsets.only(
                        left: mwidth * 0.04, top: mheight * 0.004),
                    width: mwidth * 0.756,
                    height: mheight * 0.08,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: Ottp,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'Invaild Otp';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        Ottp1 = value!;
                      },
                      decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          hintText: 'Enter Otp',
                          hintStyle: TextStyle(
                              color: Color(0xff7DAEB8),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'title')),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mheight * 0.012,
            ),
            Center(
              child: TextButton(
                onPressed: () async{
                  final isvalid = form_key.currentState?.validate();
                  if (isvalid == true) {
                    form_key.currentState?.save();
                    final credentials = PhoneAuthProvider.credential(
                        verificationId: widget.verifivationId,
                        smsCode: Ottp.text);
                    try{
                      await auth.signInWithCredential(credentials);
                      Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>Home()));
                    }catch(e){
                      ToastMessage().toastmessage(message: e.toString());
                    }

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
                      'SIGN UP',
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