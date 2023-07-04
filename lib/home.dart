import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:firebase_project/view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'get_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
TextEditingController name=TextEditingController();
TextEditingController age=TextEditingController();
TextEditingController text1 =TextEditingController();
final firestore = FirebaseFirestore.instance.collection('Post');

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
File? _image;
final form_key = GlobalKey<FormState>();
final picker = ImagePicker();
final ref=FirebaseDatabase.instance.ref('Texts');
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return Scaffold(resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Form(key: form_key,
          child: Column(
            children: [
              SizedBox(
                height: mheight*0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: mwidth*0.10),
                child: Text("Hello my World",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.red),),
              ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.10),
                child: Text("Please Add your Detalis",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,),),
              ),
      SizedBox(
          height: mheight*0.05,
      ),
              Center(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: mheight * .15,
                        width: mwidth * .3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black)),
                        child: _image != null
                            ? Image.file(
                          _image!.absolute,
                          fit: BoxFit.cover,
                        )
                            : Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: mwidth*0.2,
                        ),
                      ),
                    ),
                    Positioned(height: mheight*0.25,width: mwidth*0.99,
                        child: IconButton(onPressed: (){
                          getCameraImage();
                        },icon: Icon(Icons.camera_alt,size: 30,),)),
                  ],
                ),
              ),
      SizedBox(
          height: mheight*0.04,
      ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.04),
                child: Container(
                  height: mheight*0.05,
                  width: mwidth*0.80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()
                  ),
                  child:Row(
                      children: [
                        Container(
                          height: mheight*0.05,
                          width: mwidth*0.60,
                          child: Padding(
                            padding:  EdgeInsets.only(left: mwidth*0.02),
                            child: TextFormField(controller:name, validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field Should Not Be Empty';
                              }
                              return null;
                            },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  hintText: 'Name',
                                  hintStyle: TextStyle(color: Color(0xff90A4AE))
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ),
      SizedBox(
          height: mheight*0.03,
      ),
              Padding(
                padding:  EdgeInsets.only(left: mwidth*0.04),
                child: Container(
                  height: mheight*0.05,
                  width: mwidth*0.80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()
                  ),
                  child:Row(
                      children: [
                        Container(
                          height: mheight*0.05,
                          width: mwidth*0.60,
                          child: Padding(
                            padding:  EdgeInsets.only(left: mwidth*0.02),
                            child: TextFormField(controller:age, validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field Should Not Be Empty';
                              }
                              return null;
                            },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  hintText: 'Age',
                                  hintStyle: TextStyle(color: Color(0xff90A4AE))
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ),
      SizedBox(
          height: mheight*0.08,
      ),
      Container(
          height: mheight * .05,
          width: mwidth * .3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.red),
          child: TextButton(
            onPressed: ()async{
              final isvalid = form_key.currentState?.validate();
              if (isvalid == true) {
                final id = DateTime.now().microsecondsSinceEpoch.toString();
                firebase_storage.Reference ref =
                firebase_storage.FirebaseStorage.instance.ref('/Images/$id');
                firebase_storage.UploadTask uploadTask =
                ref.putFile(_image!.absolute);

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                uploadTask.whenComplete(() async {
                  var newUrl = await ref.getDownloadURL();
                  print(newUrl.toString());
                  firestore.doc(id).set({
                   'name':name.text,
                    'age':age.text,
                    'image': newUrl.toString(),
                  }).then((value) {
                    Navigator.of(context).pop();
                    ToastMessage().toastmessage(message: 'Uploaded');

                  }).onError((error, stackTrace) =>
                      ToastMessage().toastmessage(message: error.toString()));
                });
              }
            },
            child: Text(
              'Post',

              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )),
      SizedBox(
          height: mheight*0.04,
      ),
      Padding(
          padding:  EdgeInsets.only(top: 20,left: 250),
          child: Card(
            child: Container(
            height: mheight * .10,
            width: mwidth * .2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8)),
            child: IconButton(
              onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>ViewData())),
              icon:ImageIcon(AssetImage("assets/list icons.jpg"),


              ),
              ),
            ),
          ),
      ),
      ]),
        ),
    ));
  }
  Future<void> getGalleryImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image found');
      }
    });
  }
  Future<void> getCameraImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image found');
      }
    });
  }
  @override
  void dispose() {
    name.clear();
    age.clear();
    _image = null;
    super.dispose();
  }
}
