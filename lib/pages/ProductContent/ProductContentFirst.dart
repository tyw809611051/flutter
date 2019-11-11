import 'package:flutter/material.dart';
import '../../widgets/JdButton.dart';
import '../../services/ScreenAdaper.dart';
import '../../models/ProductContent.dart';
import '../../configs/config.dart';

class ProductContentFirst extends StatefulWidget {
  final List _productContentList;
  ProductContentFirst(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
  ProductContentItem _productContent;

  List _attr = [];
  @override
  void initState() {
    super.initState();
    this._productContent = widget._productContentList[0];

    this._attr = this._productContent.attr;
  }

  List<Widget> _getAttrItemWidget(attrItem) {
    List<Widget> attrItemList = [];

    attrItem.list.forEach( (item) {
      attrItemList.add(
        Container(
                  margin: EdgeInsets.all(10),
                  child: Chip(
                    label: Text("$item"),
                    padding: EdgeInsets.all(10),
                  ),
                )
      );
    });

    return attrItemList;
  }

  //  渲染attr
  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];
    this._attr.forEach( (attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdaper.width(100),
            child: Padding(
              padding: EdgeInsets.only(
                  top: ScreenAdaper.height(30)),
              child: Text(
                "${attrItem.cate}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: ScreenAdaper.width(610),
            child: Wrap(
              children: this._getAttrItemWidget(attrItem),
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
                      children: this._getAttrWidget(),
                    )
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
                  Text("115, 黑色, XL, 1件"),
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
