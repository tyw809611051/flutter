import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../models/ProductModel.dart';
import '../configs/config.dart';
import '../widgets/LoadingWidget.dart';

class ProductList extends StatefulWidget {
  Map arguments;
  ProductList({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 用于上拉分页
  ScrollController _scrollController = ScrollController();

  List _productList = [];

  // 分页
  int _page = 1;
  String _sort = "";
  bool flag = true;
  bool _hasMore = true;
  int _pageSize = 8;
  @override
  void initState() {
    super.initState();
    _getProductListData();

    // 监听滚动条滚动事件
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (this.flag && this._hasMore) {
          _getProductListData();
        }
      }
      ;
    });
  }

  // 二级导航数据
  List _subHeaderList = [
    {"id": 1, "title": "综合", "fields": "all", "sort": -1},
    {"id": 2, "title": "销量", "fields": "salecount", "sort": -1},
    {"id": 3, "title": "价格", "fields": "price", "sort": -1},
    {"id": 4, "title": "筛选"},
  ];

  int _selectHeader = 1;

  // 获取商品列表的数据
  _getProductListData() async {
    setState(() {
      this.flag = false;
    });
    var api =
        "${Config.apiUrl}api/plist?cid=${widget.arguments['cid']}&page=${this._page}&pageSize=${this._pageSize}&sort=${this._sort}";
    print(api);
    var response = await Dio().get(api);

    // print(focusData.data is Map);

    var productList = ProductModel.fromJson(response.data);
    bool hasMore = true;
    if (productList.result.length < this._pageSize) {
      hasMore = false;
    }
    setState(() {
      this._productList.addAll(productList.result);
      this._page++;
      this.flag = true;
      this._hasMore = hasMore;
    });
  }

  _showMore(index) {
    if (this._hasMore) {
      return (index == this._productList.length - 1)
          ? LoadingWidget()
          : Text("");
    } else {
      return (index == this._productList.length - 1)
          ? Text("---我的有底线的---")
          : Text("");
    }
  }

  _subHeaderChange(id) {
    if (id == 4) {
      _scaffoldKey.currentState.openEndDrawer();
      setState(() {
        this._selectHeader = id;
      });
    } else {
      setState(() {
        this._selectHeader = id;
        this._sort =
            "${this._subHeaderList[id - 1]['fields']}_${this._subHeaderList[id - 1]['sort']}";

        // 重置分页
        this._page = 1;
        // 重置数据
        this._productList = [];

        // 重置hasmore
        this._hasMore = true;

        this._subHeaderList[id - 1]['sort'] =
            this._subHeaderList[id - 1]['sort'] * -1;
        _scrollController.jumpTo(0);
        this._getProductListData();
      });
    }
  }

  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: this._productList.length,
          itemBuilder: (context, index) {
            String pic = this._productList[index].pic;
            pic = Config.apiUrl + pic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenAdaper.width(180),
                      height: ScreenAdaper.height(180),
                      child: Image.network(
                        "${pic}",
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
                              "${this._productList[index].title}",
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
                                      color:
                                          Color.fromRGBO(230, 230, 230, 0.9)),
                                  child: Text("4g"),
                                ),
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          Color.fromRGBO(230, 230, 230, 0.9)),
                                  child: Text("5g"),
                                ),
                              ],
                            ),
                            Text(
                              "¥${this._productList[index].price}",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                _showMore(index),
              ],
            );
          },
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  // 显示header Icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (this._subHeaderList[id - 1]['sort'] == 1) {
        return Icon(Icons.arrow_drop_down);
      }
      return Icon(Icons.arrow_drop_up);
    }

    return Text("");
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
          children: this._subHeaderList.map((value) {
            return Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("${value['title']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: (this._selectHeader == value['id'])
                                    ? Colors.red
                                    : Colors.black54)),
                        _showIcon(value['id']),
                      ],
                    )),
                onTap: () {
                  _subHeaderChange(value['id']);
                },
              ),
            );
          }).toList(),
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
