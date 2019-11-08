import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';

class ProductList extends StatefulWidget {
  Map arguments;
  ProductList({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _productListWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: ScreenAdaper.width(180),
                    height: ScreenAdaper.height(180),
                    child: Image.network(
                      "https://www.itying.com/images/flutter/list2.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenAdaper.height(180),
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "讯景（XFX）RX 5700 8GB 战狼版 boost1750MHz/14Gbps 256bit GDDR6 显卡",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: ScreenAdaper.height(36),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9)),
                                child: Text("4g"),
                              ),
                              Container(
                                height: ScreenAdaper.height(36),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9)),
                                child: Text("5g"),
                              ),
                            ],
                          ),
                          Text(
                            "¥990",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  // 顶部tab栏
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdaper.height(80),
      width: ScreenAdaper.width(750),
      child: Container(
        height: ScreenAdaper.height(80),
        width: ScreenAdaper.width(750),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: Color.fromRGBO(233, 233, 233, 0.9),
        ))),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("综合",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red)),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("销量",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red)),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("价格",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red)),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text("筛选",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red)),
                ),
                onTap: () {
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 会删除
    // ScreenAdaper.init(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("商品列表"),
          actions: <Widget>[
            Text(""),
          ],
        ),
        endDrawer: Drawer(
          child: Text("侧边栏"),
        ),
        body: Stack(
          children: <Widget>[
            _productListWidget(),
            _subHeaderWidget(),
          ],
        ));
  }
}
