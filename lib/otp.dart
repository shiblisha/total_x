import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/home.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:flutter/material.dart';



class Otp_form extends StatefulWidget {
  final verificationId;
  const Otp_form({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<Otp_form> createState() => _Otp_formState();
}
TextEditingController otp=TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;
class _Otp_formState extends State<Otp_form> {
  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return Scaffold(resizeToAvoidBottomInset: false,
        body: Padding(
      padding: EdgeInsets.only(left: 30, top: 80),
      child: Column(
        children: [
          Padding(
          padding: EdgeInsets.only(left: mwidth * 0.12),
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
                        width: mwidth * 0.7,
                        child: Padding(
                          padding: EdgeInsets.only(left: mwidth * 0.02),
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintText: 'Enter Otp',
                                hintStyle: TextStyle(color: Color(0xff90A4AE))),
                          ),
                        )
                    )
                  ])
          )
          ),
          SizedBox(
        height: mwidth * .1,
          ),
          Container(
          height: mheight * .05,
          width: mwidth * .3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.red),
          child: TextButton(
              child: Text(
                'Submit',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: ()async{
                final credentials = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: otp.text);
                try{
                  await auth.signInWithCredential(credentials);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>Home()));
                }catch(e){
                  ToastMessage().toastmessage(message: e.toString());
                }
              })),
        ],
      ),
    ));
  }
}
