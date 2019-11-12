import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cisslab/models/ProductModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdaper.dart';
import 'package:dio/dio.dart';

//轮播图类模型
import '../../models/FocusModel.dart';
import '../../configs/config.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  _getFocusData() async {
    var api = 'http://jd.itying.com/api/focus';

    var response = await Dio().get(api);

    // print(focusData.data is Map);

    var focusList = FocusModel.fromJson(response.data);

    // print(focusList.result);

    // focusList.result.forEach((value){
    //   print(value.title);
    //   print(value.pic);
    // });

    setState(() {
      this._focusData = focusList.result;
    });
  }

  _getHotProductData() async {
    var api = "${Config.apiUrl}api/plist?is_hot=1";
    var response = await Dio().get(api);

    // print(focusData.data is Map);

    var hotProductList = ProductModel.fromJson(response.data);

    setState(() {
      this._hotProductList = hotProductList.result;
    });
  }

  _getBestProductData() async {
    var api = "${Config.apiUrl}api/plist?is_best=1";
    var response = await Dio().get(api);

    // print(focusData.data is Map);

    var bestProductList = ProductModel.fromJson(response.data);

    setState(() {
      this._bestProductList = bestProductList.result;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    if (this._focusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                String pic = this._focusData[index].pic;
                pic = Config.apiUrl + pic.replaceAll('\\', '/');

                return new Image.network(
                  pic,
                  fit: BoxFit.fill,
                );
              },
              itemCount: this._focusData.length,
              pagination: new SwiperPagination(),
              autoplay: true),
        ),
      );
    } else {
      return Text('加载中...');
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdaper.height(32),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left: ScreenAdaper.width(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: ScreenAdaper.width(10),
      ))),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
  //热门商品

  Widget _hotProductListWidget() {
    if (this._hotProductList.length > 0) {
      return Container(
        height: ScreenAdaper.height(234),
        padding: EdgeInsets.all(ScreenAdaper.width(20)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (contxt, index) {
            String pic = this._hotProductList[index].pic;
            pic = Config.apiUrl + pic.replaceAll("\\", "/");
            return Column(
              children: <Widget>[
                Container(
                  height: ScreenAdaper.height(140),
                  width: ScreenAdaper.width(140),
                  margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                  child: Image.network(pic, fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                  height: ScreenAdaper.height(44),
                  child: Text(
                    "¥${this._hotProductList[index].price}",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          itemCount: this._hotProductList.length,
        ),
      );
    } else {
      return Text("加载中...");
    }
  }

  Widget _recProductListWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._bestProductList.map((value) {
          var itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;
          String pic = Config.apiUrl + value.pic;
          pic = pic.replaceAll('\\', '/');
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/productContent',
                  arguments: {"id": value.sId});
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: itemWidth,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      //防止服务器返回的图片大小不一致导致高度不一致问题
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        "${pic}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                    child: Text(
                      "${value.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "¥${value.price}",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("¥${value.oldPrice}",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  //推荐商品
  _recProductItemWidget() {
    var itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      width: itemWidth,
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: AspectRatio(
              //防止服务器返回的图片大小不一致导致高度不一致问题
              aspectRatio: 1 / 1,
              child: Image.network(
                "https://www.itying.com/images/flutter/list1.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: Text(
              "2019夏季新款气质高贵洋气阔太太有女人味中长款宽松大码",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "¥188.0",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("¥198.0",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ScreenAdaper.init(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.center_focus_weak),
          onPressed: null,
        ),
        title: InkWell(
          child: Container(
            height: ScreenAdaper.height(70),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text(
                  'jdshop',
                  style: TextStyle(fontSize: ScreenAdaper.size(28)),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.message,
              size: 28,
              color: Colors.black87,
            ),
            onPressed: null,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          _swiperWidget(),
          SizedBox(height: ScreenAdaper.height(20)),
          _titleWidget("猜你喜欢"),
          SizedBox(height: ScreenAdaper.height(20)),
          _hotProductListWidget(),
          _titleWidget("热门推荐"),
          _recProductListWidget(),
        ],
      ),
    );
  }
}
