import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}
final firestore = FirebaseFirestore.instance.collection('Post').snapshots();
class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    final double itemHeight = mheight * 0.28;
    final double itemWidth = size.width / 2;
    return Scaffold(
       body: StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                return GridView.count(
                    childAspectRatio: (itemWidth / itemHeight),
                    padding: EdgeInsets.only(
                        top: mheight * 0.016,
                        left: mwidth * 0.028,
                        right: mwidth * 0.02),
                    crossAxisCount: 2,
                    crossAxisSpacing: mheight * 0.002,
                    mainAxisSpacing: mwidth * 0.005,
                    shrinkWrap: true,
                    children: List.generate(
                      snapshot.data!.docs.length,
                      growable: false,
                          (index) {
                        return Card(
                          elevation: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: mheight * 0.01,
                                ),
                                Container(
                                  width: mwidth * 0.42,
                                  height: mheight * 0.145,
                                  child: Image.network(
                                    snapshot.data!.docs[index]['image']
                                        .toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: mheight * 0.005,
                                ),
                                Container(
                                    width: mwidth * 0.42,
                                    height: mheight * 0.09,
                                    padding:
                                    EdgeInsets.only(left: mwidth * 0.013),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['name']
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 2,
                                        ),
                                        Text(
                                          snapshot
                                              .data!.docs[index]['age']
                                              .toString(),
                                          style: TextStyle(
                                              color: Color(0xff385f67),
                                              fontSize: 12),
                                          maxLines: 2,
                                        ),

                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    ));
              } else {
                return SizedBox();
              }
            }));
  }
  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }
}
