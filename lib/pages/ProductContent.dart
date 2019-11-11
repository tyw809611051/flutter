import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import 'package:dio/dio.dart';

import './ProductContent/ProductContentFirst.dart';
import './ProductContent/ProductContentSecond.dart';
import './ProductContent/ProductContentThird.dart';
import '../widgets/JdButton.dart';
import '../models/ProductContent.dart';
import '../configs/config.dart';
import '../widgets/LoadingWidget.dart';

class ProductContent extends StatefulWidget {
  final Map arguments;
  ProductContent({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {

  List _productContentList=[];

  @override
  void initState() { 
    super.initState();
    
    this._getContentData();
  }

  _getContentData() async{
    var api = "${Config.apiUrl}api/pcontent?id=${widget.arguments['id']}";
    print(api);
    var response = await Dio().get(api);

    var productContent = ProductContentModel.fromJson(response.data);
    setState(() {
     this._productContentList.add(productContent.result); 
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenAdaper.width(400),
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(
                      child: Text("商品"),
                    ),
                    Tab(
                      child: Text("详情"),
                    ),
                    Tab(
                      child: Text("评价"),
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                  context: context,
                  position:
                      RelativeRect.fromLTRB(ScreenAdaper.width(600), 80, 10, 0),
                  items: [
                    PopupMenuItem(
                      child: Row(
                        children: <Widget>[Icon(Icons.home), Text("首页")],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: <Widget>[Icon(Icons.search), Text("搜索")],
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
        body: this._productContentList.length > 0 ? Stack(
          children: <Widget>[
            TabBarView(
              children: <Widget>[
                ProductContentFirst(this._productContentList),
                ProductContentSecond(this._productContentList),
                ProductContentThird(),
              ],
            ),
            Positioned(
              width: ScreenAdaper.width(750),
              height: ScreenAdaper.height(100),
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black38, width: 1)),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                      width: 100,
                      height: 80,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.shopping_cart),
                          Text("购物车"),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: JdButton(
                        color: Color.fromRGBO(253, 1, 0, 0.9),
                        text: "加入购物车",
                        cb: () {
                          print("加入购物车");
                        },
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: JdButton(
                        color: Color.fromRGBO(253, 165, 0, 0.9),
                        text: "立即购买",
                        cb: () {
                          print("立即购买");
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ) : LoadingWidget(),
      ),
    );
  }
}
