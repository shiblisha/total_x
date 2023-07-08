import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'filteringf.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

TextEditingController search = TextEditingController();
final ref1 = FirebaseFirestore.instance.collection('Post').snapshots();

class _ViewDataState extends State<ViewData> {
  late ScrollController _scrollController;
  late List<DocumentSnapshot> _dataList;
  bool _isLoading = false;
  int _batchSize = 10;

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
          .orderBy('name')
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Container(
            width: mwidth * 0.8,
            height: mheight * 0.065,
            decoration: BoxDecoration(
              color: Color(0xffF3F3F3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              onFieldSubmitted: (value) {
                setState(() {});
              },
              controller: search,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: Color(0xff90A4AE)),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Color(0xff828282),
                  size: size.width * 0.065,
                ),
              ),
            ),
          ),
          SizedBox(
            width: mwidth * 0.05,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterPage()),
              );
            },
            icon: Icon(
              Icons.filter_list_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ref1,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            return LazyLoadScrollView(
              onEndOfPage: _fetchData,
              isLoading: _isLoading,
              child: SizedBox(height: mheight,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount:  _dataList.length + (_isLoading ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < _dataList.length) {
                      final document = _dataList[index];
                      final name = document['name'].toString();
                      if (name
                          .toLowerCase()
                          .contains(search.text.toLowerCase())) {
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
                                  padding: EdgeInsets.only(left: mwidth * 0.013),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      }
                      if (search.text.isEmpty) {
                        return Card(
                          elevation: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
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
                                  padding: EdgeInsets.only(left: mwidth * 0.013),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      }
                    } else if (_isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
