import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'filterShow.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}


class _FilterPageState extends State<FilterPage> {

  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(backgroundColor:Color(0xff004B59),
        title: Text("Filterd by age",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white),),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: mheight*0.02,),
          Center(
            child: GestureDetector(onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowFilterd(from: 0, to: 10,)));},
              child: Card(elevation: 3,

                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height:mheight*0.06,
                  width: mwidth*0.85,
                  color: Colors.white12,
                  child: Row(
                    children: [
                      SizedBox(width: mwidth*0.02,),
                      Text("0 to10",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      SizedBox(width: mwidth*0.6,),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),SizedBox(height: mheight*0.02,),
          Center(
            child: GestureDetector(onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowFilterd(from: 11, to: 20,)));},
              child: Card(elevation: 3,

                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height:mheight*0.06,
                  width: mwidth*0.85,
                  color: Colors.white12,
                  child: Row(
                    children: [
                      SizedBox(width: mwidth*0.02,),
                      Text("10 to20",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      SizedBox(width: mwidth*0.6,),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),SizedBox(height: mheight*0.02,),
          Center(
            child: GestureDetector(onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowFilterd(from: 21, to: 30,)));},
              child: Card(elevation: 3,

                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height:mheight*0.06,
                  width: mwidth*0.85,
                  color: Colors.white12,
                  child: Row(
                    children: [
                      SizedBox(width: mwidth*0.02,),
                      Text("20 to 30",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      SizedBox(width: mwidth*0.59,),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),SizedBox(height: mheight*0.02,),
          Center(
            child: GestureDetector(onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowFilterd(from: 31, to: 40,)));},
              child: Card(elevation: 3,

                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height:mheight*0.06,
                  width: mwidth*0.85,
                  color: Colors.white12,
                  child: Row(
                    children: [
                      SizedBox(width: mwidth*0.02,),
                      Text("30 to40",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      SizedBox(width: mwidth*0.6,),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ),SizedBox(height: mheight*0.02,),
          Center(
            child: GestureDetector(onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowFilterd(from: 41, to: 10000,)));},
              child: Card(elevation: 3,

                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height:mheight*0.06,
                  width: mwidth*0.85,
                  color: Colors.white12,
                  child: Row(
                    children: [
                      SizedBox(width: mwidth*0.02,),
                      Text("40 to above",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      SizedBox(width: mwidth*0.52,),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
