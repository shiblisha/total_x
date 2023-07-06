import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/toastmessege.dart';
import 'package:firebase_project/view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

TextEditingController name = TextEditingController();
TextEditingController age = TextEditingController();
TextEditingController text1 = TextEditingController();
final firestore = FirebaseFirestore.instance.collection('Post');

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
File? _image;

final form_key = GlobalKey<FormState>();
final picker = ImagePicker();
final ref = FirebaseDatabase.instance.ref('Texts');

class _HomeState extends State<Home> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var mheight = MediaQuery.of(context).size.height;
        var mwidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text(
            'Select Image From',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xff004B59)),
          ),
          content: SingleChildScrollView(
            // Add SingleChildScrollView
            child: Container(
              constraints: BoxConstraints(maxHeight: mheight * 0.1),
              // Set maximum height
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      getCameraImage();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.camera_alt,
                            size: 30, color: Color(0xff004B59)),
                        SizedBox(width: mwidth * 0.02),
                        Text("Camera",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff004B59)))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mheight * 0.026,
                  ),
                  GestureDetector(
                    onTap: () {
                      getGalleryImage();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.photo, size: 30, color: Color(0xff004B59)),
                        SizedBox(width: mwidth * 0.02),
                        Text("Gallery",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff004B59)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Form(
            key: form_key,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              SizedBox(
                height: mheight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(left: mwidth * 0.10),
                child: Text(
                  "Enter User\nDetails!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xff004B59)),
                ),
              ),
              SizedBox(
                height: mheight * 0.05,
              ),
              Center(
                child: Stack(
                  children: [
                    Center(
                        child: Container(
                      height: mheight * 0.18,
                      width: mwidth * 0.4,
                      decoration: BoxDecoration(
                          color: Color(0xff004B59),
                          borderRadius: BorderRadius.circular(100)),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                _image!.absolute,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/add image.png',
                                width: mwidth * 0.1,
                                height: mheight * 0.02,
                              )),
                    )),
                    Positioned(
                        height: mheight * 0.3,
                        width: mwidth * 1.1,
                        child: IconButton(
                          onPressed: () {
                            _showDialog(context);
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: mheight * 0.04,
              ),
              Center(
                child: Container(
                  height: mheight * 0.05,
                  width: mwidth * 0.80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: Row(children: [
                    Container(
                      height: mheight * 0.05,
                      width: mwidth * 0.60,
                      child: Padding(
                        padding: EdgeInsets.only(left: mwidth * 0.02),
                        child: TextFormField(textInputAction: TextInputAction.next,
                          controller: name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field Should Not Be Empty';
                            }
                            return null;
                          },
                              decoration:
                              InputDecoration(

                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                      color: Color(0xff90A4AE)))

                            ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: mheight * 0.03,
              ),
              Center(
                child: Container(
                  height: mheight * 0.05,
                  width: mwidth * 0.80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: Row(children: [
                    Container(
                      height: mheight * 0.05,
                      width: mwidth * 0.60,
                      child: Padding(
                        padding: EdgeInsets.only(left: mwidth * 0.02),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: age,
                          validator: (value) {
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
                              hintStyle: TextStyle(color: Color(0xff90A4AE))),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: mheight * 0.08,
              ),
              Center(
                child: Container(
                    height: mheight * .05,
                    width: mwidth * .7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff004B59)),
                    child: TextButton(
                      onPressed: () async {
                        final isvalid = form_key.currentState?.validate();
                        if (isvalid == true) {
                          final id =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          firebase_storage.Reference ref = firebase_storage
                              .FirebaseStorage.instance
                              .ref('/Images/$id');
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
                              'name': name.text,
                              'age': age.text,
                              'image': newUrl.toString(),
                            }).then((value) {
                              name.clear();
                              age.clear();
                              setState(() {
                                _image = null;
                              });

                              Navigator.of(context).pop();
                              ToastMessage().toastmessage(message: 'Uploaded');
                            }).onError((error, stackTrace) => ToastMessage()
                                .toastmessage(message: error.toString()));
                          });
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )),
              ),
              SizedBox(
                height: mheight * 0.04,
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: mheight * 0.05, left: mwidth * 0.75),
                child: Card(
                  child: Container(
                    height: mheight * .10,
                    width: mwidth * .2,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext a) => ViewData())),
                        icon: Icon(
                          Icons.person,
                          size: 35,
                        )),
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
