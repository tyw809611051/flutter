import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      height: ScreenUtil.getInstance().setHeight(40),
      margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(10)),
      padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(10)),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.red,
            width: ScreenUtil.getInstance().setHeight(10),
          ),
        ), 
      ),
      child: Text(value,
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: 10,),
        _titleWidget('猜你喜欢'),
      ],
    );
  }
}
