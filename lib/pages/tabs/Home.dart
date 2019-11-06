import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdaper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播图
  Widget _swiperWidget() {
    List<Map> imagerList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    ];
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              imagerList[index]['url'],
              fit: BoxFit.fill,
            );
          },
          itemCount: imagerList.length,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ),
      ),
    );
  }

  // 小标题
  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdaper.height(40),
      margin: EdgeInsets.only(left: ScreenAdaper.width(10)),
      padding: EdgeInsets.only(left: ScreenAdaper.width(10)),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.red,
            width: ScreenAdaper.height(10),
          ),
        ), 
      ),
      child: Text(value,
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  // 热销商品
  Widget _hotProductListWidget() {
    return Container(
      height: ScreenAdaper.height(234),
      padding: EdgeInsets.all(ScreenAdaper.width(20)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index) {
          return Column(
            children: <Widget>[
              // 图片
              Container(
                height: ScreenAdaper.height(140),
                width: ScreenAdaper.height(140),
                margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                child: Image.network("https://www.itying.com/images/flutter/hot${index+1}.jpg",fit: BoxFit.cover,),
              ),
              // 文本
              Container(
                padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                child: Text("热销商品"),
              ),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // 屏幕适配
    ScreenAdaper.init(context);

    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: 10,),
        _titleWidget('猜你喜欢'),
        _hotProductListWidget(),
      ],
    );
  }
}
