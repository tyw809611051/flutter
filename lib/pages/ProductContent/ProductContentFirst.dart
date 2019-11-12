import 'package:flutter/material.dart';
import 'package:flutter_cisslab/services/CartServices.dart';
import '../../widgets/JdButton.dart';
import '../../services/ScreenAdaper.dart';
import '../../models/ProductContent.dart';
import '../../configs/config.dart';
import '../../services/EventBus.dart';
import '../ProductContent/CartNum.dart';

class ProductContentFirst extends StatefulWidget {
  final List _productContentList;
  ProductContentFirst(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  ProductContentItem _productContent;

  List _attr = [];

  String _selectedAttr;

  var actionEventBus;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this._productContent = widget._productContentList[0];

    this._attr = this._productContent.attr;

    this._initAttr();

   
    this.actionEventBus = eventBus.on<ProductContentEvent>().listen( (event) {
      print(event);

    });
  }

  void dispose() {
    super.dispose();

    this.actionEventBus.cancel();
  }

  // 初始化attr，格式化数据
  _initAttr() {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({
            "title": attr[i].list[j],
            "checked": true,
          });
        } else {
          attr[i].attrList.add({
            "title": attr[i].list[j],
            "checked": false,
          });
        }
      }
    }

    this._getSelectedAttrValue();
  }

  // 改变属性值
  _changeAttr(cate, title,setBottomState) {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]['checked'] = false;
          if (title == attr[i].attrList[j]['title']) {
            attr[i].attrList[j]['checked'] = true;
          }
        }
      }
    }

    setBottomState(() {
      this._attr = attr;
    });

    this._getSelectedAttrValue();
  }

  // 获取选中的值
  _getSelectedAttrValue() {
    var _list = this._attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
 
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]['title']);
        }
      }
    }

    setState(() {
     this._selectedAttr = tempArr.join(','); 
     this._productContent.selectedAttr = this._selectedAttr;
    });
  }

  List<Widget> _getAttrItemWidget(attrItem,setBottomState) {
    List<Widget> attrItemList = [];

    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            this._changeAttr(attrItem.cate, item['title'],setBottomState);
          },
          child: Chip(
            label: Text("${item['title']}"),
            padding: EdgeInsets.all(10),
            backgroundColor: item['checked'] ? Colors.red : Colors.black54,
          ),
        ),
      ));
    });

    return attrItemList;
  }

  //  渲染attr
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdaper.width(100),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdaper.height(30)),
              child: Text(
                "${attrItem.cate}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: ScreenAdaper.width(610),
            child: Wrap(
              children: this._getAttrItemWidget(attrItem,setBottomState),
            ),
          ),
        ],
      ));
    });

    return attrList;
  }

  // 底部弹出框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              return GestureDetector(
                onTap: () {
                  return false;
                },
                child: Stack(
                  children: <Widget>[
                    ListView(
                      padding: EdgeInsets.all(10),
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: this._getAttrWidget(setBottomState),
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: ScreenAdaper.height(80),
                          child: InkWell(
                            onTap: () {
                              _attrBottomSheet();
                            },
                            child: Row(
                              children: <Widget>[
                                Text("数量",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                                CartNum(this._productContent),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      width: ScreenAdaper.width(750),
                      height: ScreenAdaper.height(76),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () {
                                print(111);
                                CartServices.addCart(this._productContent);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () {
                                print(111);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var pic = this._productContent.pic;
    pic = Config.apiUrl + pic.replaceAll('\\', '/');
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network("${pic}", fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "${this._productContent.title}",
              style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenAdaper.size(36),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "${this._productContent.subTitle}",
              style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenAdaper.size(28),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text("价格:"),
                      Text(
                        "¥${this._productContent.price}",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenAdaper.size(36),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("原价:"),
                      Text(
                        "¥${this._productContent.oldPrice}",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: ScreenAdaper.size(36),
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: ScreenAdaper.height(80),
            child: InkWell(
              onTap: () {
                this._attrBottomSheet();
              },
              child: Row(
                children: <Widget>[
                  Text(
                    "已选",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${this._selectedAttr}"),
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            height: ScreenAdaper.height(80),
            child: Row(
              children: <Widget>[
                Text(
                  "运费",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("免运费"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
