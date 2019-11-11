import 'package:flutter/material.dart';
import 'package:flutter_cisslab/widgets/JdButton.dart';
import '../../services/ScreenAdaper.dart';

class ProductContentFirst extends StatefulWidget {
  ProductContentFirst({Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
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
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Container(
                              width: ScreenAdaper.width(100),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenAdaper.height(30)),
                                child: Text(
                                  "颜色",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: ScreenAdaper.width(610),
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network("https://www.itying.com/images/flutter/p1.jpg",
                fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Apple iPhone 11 (A2223) 128GB 黑色 移动联通电信4G手机 双卡双待",
              style: TextStyle(
                color: Colors.black87,
                fontSize: ScreenAdaper.size(36),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Apple iPhone 11 (A2223) 128GB 黑色 移动联通电信4G手机 双卡双待",
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
                        "¥23",
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
                        "¥23",
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
