import 'package:flutter/material.dart';

import './Home.dart';
import './Category.dart';
import './Cart.dart';
import './User.dart';

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
    return Scaffold(
         appBar: AppBar(
           title: Text('jdshop'),
         ),
        //  body: this._pageList[this._currentIndex],
        body: PageView(
          controller: _pageController,
          children: this._pageList,
          onPageChanged: (index) {
            _currentIndex = index;
          },
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