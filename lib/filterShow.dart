import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowFilterd extends StatefulWidget {
  final int from;
  final int to;
  const ShowFilterd({Key? key,required this.from,required this.to}) : super(key: key);

  @override
  State<ShowFilterd> createState() => _ShowFilterdState();
}
final ref1 = FirebaseFirestore.instance.collection('Post').snapshots();
class _ShowFilterdState extends State<ShowFilterd> {
  late ScrollController _scrollController;
  late List<DocumentSnapshot> _dataList;
  bool _isLoading = false;
  int _batchSize = 5;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _dataList = [];
    _fetchData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      Query query = FirebaseFirestore.instance
          .collection('Post')
          .orderBy('name') // Add your desired ordering criteria
          .limit(_batchSize);

      if (_dataList.isNotEmpty) {
        query = query.startAfterDocument(_dataList.last);
      }

      final QuerySnapshot querySnapshot = await query.get();

      setState(() {
        _isLoading = false;
        _dataList.addAll(querySnapshot.docs);
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _fetchData();
    }
  }
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    return Scaffold(

        body: StreamBuilder<QuerySnapshot>(
            stream: ref1,
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
                print(snapshot.data!.docs.length);
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: _dataList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < _dataList.length) {
                        final document = _dataList[index];
                        final age = document['age'].toString();
                        if (int.parse(age)>=widget.from&&int.parse(age)<=widget
                        .to) {
                          return Card(
                            elevation: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: mheight * 0.01,
                                  ),
                                  Container(
                                    width: mwidth * 0.42,
                                    height: mheight * 0.145,
                                    child: Image.network(
                                      document['image'].toString(),
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
                                          document['name'].toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 2,
                                        ),
                                        Text(
                                          document['age'].toString(),
                                          style: TextStyle(
                                            color: Color(0xff385f67),
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else{
                          return SizedBox();
                        }
                      } else if (_isLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return SizedBox();
                      }
                    });
              } else {
                return SizedBox();
              }
            }));
  }
}
