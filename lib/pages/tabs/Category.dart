import 'package:flutter/material.dart';
import 'package:flutter_cisslab/services/ScreenAdaper.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Row(
         children: <Widget>[
           Container(
             width: ScreenAdaper.width(140),
             height: double.infinity,
             child: ListView.builder(
               itemCount: 20,
               itemBuilder: (context,index) {
                 return Column(
                   children: <Widget>[
                     InkWell(
                       onTap: () {
                         setState(() {
                          _selectIndex = index; 
                         });
                       },
                       child: Container(
                         width: double.infinity,
                         height: ScreenAdaper.height(56),
                         child: Text("我是${index}条"),
                         color: _selectIndex==index?Colors.red:Colors.white,
                       ),
                     ),
                   ],
                 );
               },
             ),
           ),
           Expanded(
             flex: 1,
             child: Text("我是右侧"),
           ),
         ],
       ),
    );
  }
}