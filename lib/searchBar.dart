import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({Key? key}) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}
String search_page ="";
final firestore = FirebaseFirestore.instance.collection('Post').snapshots();
TextEditingController search = TextEditingController();

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffE8F1F3),
          title: Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: mwidth * 0.04),
                  width: mwidth * 0.756,
                  height: mheight * 0.05,
                  child: TextFormField(onFieldSubmitted: (value){
                    search.text=value;
                    search.text  = value.trimRight();
                  },
                    controller: search,
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintText: 'Search by keyword or Brand',
                        hintStyle: TextStyle(
                            color: Color(0xff7DAEB8),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'title')),
                  )),
            ],
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: mheight * 0.05),
            child: StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text(
                      'error',
                      style: TextStyle(color: Colors.purple),
                    );
                  }
                  if (snapshot.hasData) {

                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          if (search.text.toString().toUpperCase() ==
                              snapshot.data!.docs[index]['name']
                                  .toString()
                                  .toUpperCase()) {
                            return Card(
                              child: Container(
                                height: mheight * 0.15,
                                width: mwidth * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: mwidth * 0.03,
                                    ),
                                    Container(
                                      height: mheight * 0.15,
                                      width: mwidth * 0.25,
                                      child: Image.network(
                                          snapshot.data!.docs[index]['image']),
                                    ),
                                    SizedBox(
                                      width: mwidth * 0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: mheight * 0.02),
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['price'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.amber),
                                          ),
                                          SizedBox(
                                            height: mheight * 0.02,
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['name'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: mheight * 0.02),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: mwidth * 0.02,
                                                ),
                                                Text(
                                                  snapshot.data!
                                                      .docs[index]['location'],

                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        });} else {
                    return SizedBox();
                  }
                })));
  }
}