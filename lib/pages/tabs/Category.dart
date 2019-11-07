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
      // 右侧宽度
  var leftWidth = ScreenAdaper.getScreenWidth()/4;
  // 右侧宽度=总宽度-左侧宽度-GridView外侧原生padding值-GridView中间的间距
  var rightItemWidth = (ScreenAdaper.getScreenWidth()-leftWidth-20-20)/3;
  rightItemWidth = ScreenAdaper.width(rightItemWidth);
  var rightItemHeight = rightItemWidth+ScreenAdaper.height(28);

    return Container(
       child: Row(
         children: <Widget>[
           
           Container(

             width: leftWidth,
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
             child: Container(
               padding: EdgeInsets.all(10),
               height: double.infinity,
               color: Color.fromRGBO(240, 246, 246, 0.9),
               child: GridView.builder(
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 3,
                   childAspectRatio: rightItemWidth/rightItemHeight,
                   crossAxisSpacing: 10,
                   mainAxisSpacing: 10
                   ),
                 itemCount: 16,
                 itemBuilder: (context,index) {
                   return Container(
                    //  padding: EdgeInsets.all(10),
                     child: Column(
                       children: <Widget>[
                         AspectRatio(
                           aspectRatio: 1/1,
                           child: Image.network("https://www.itying.com/images/flutter/list8.jpg",fit: BoxFit.cover,),
                         ),
                         Container(
                           height: ScreenAdaper.height(35),
                           child: Text("女装"),
                         ),
                       ],
                     ),
                   );
                 },
               ),
             ),
           ),
         ],
       ),
    );
  }
}