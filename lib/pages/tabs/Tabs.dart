import 'package:flutter/material.dart';

import './Home.dart';
import './Category.dart';
import './Cart.dart';
import './User.dart';
import '../../services/ScreenAdaper.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() { 
    super.initState();
    this._pageController = new PageController(initialPage: this._currentIndex);
  }
  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
        //  appBar: AppBar(
        //    leading: IconButton(
        //      icon: Icon(Icons.center_focus_weak),
        //      onPressed: null,
        //    ),
        //    title: InkWell(
        //      child: Container(
        //        height: ScreenAdaper.height(70),
        //        decoration: BoxDecoration(
        //          color: Color.fromRGBO(233, 233, 233, 0.8),
        //          borderRadius: BorderRadius.circular(30),
        //        ),
        //        padding: EdgeInsets.only(left: 10),
        //        child: Row(
        //          crossAxisAlignment: CrossAxisAlignment.center,
        //          children: <Widget>[
        //            Icon(Icons.search),
        //            Text('jdshop',style: TextStyle(fontSize: ScreenAdaper.size(28)),)
        //          ],
        //        ),
        //      ),
        //      onTap: () {
        //       Navigator.pushNamed(context, '/search');
        //      },
        //    ),
        //    actions: <Widget>[
        //      IconButton(
        //        icon: Icon(Icons.message,size: 28,color: Colors.black87,),
        //        onPressed: null,
        //      )
        //    ],
        //  ),
       
        //  body: this._pageList[this._currentIndex],
        body: PageView(
          controller: _pageController,
          children: this._pageList,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          physics: NeverScrollableScrollPhysics(), //禁止pageview滑动
        ),
         bottomNavigationBar: BottomNavigationBar(
           currentIndex: this._currentIndex,
           onTap: (index) {
             setState(() {
              this._currentIndex = index; 
              this._pageController.jumpToPage(index);
             });
           },
           type: BottomNavigationBarType.fixed,
           fixedColor: Colors.red,
           items: [
             BottomNavigationBarItem(
               icon: Icon(Icons.home),
               title: Text('首页'),
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.category),
               title: Text('分类'),
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.shopping_cart),
               title: Text('购物车'),
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.people),
               title: Text('我的'),
             ),
           ],
         ),
       );
  }
}