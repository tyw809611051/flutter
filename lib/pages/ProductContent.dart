import 'package:flutter/material.dart';

class ProductContent extends StatefulWidget {
  final Map arguments;
  ProductContent({Key key,this.arguments}) : super(key: key);

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
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
        ),
        body: TabBarView(
          children: <Widget>[
            Text("商品1111"),
            Text("商品2222"),
            Text("商品3333"),
          ],
        ),
      ),
    );
  }
}