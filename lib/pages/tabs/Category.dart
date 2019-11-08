import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../services/ScreenAdaper.dart';
import '../../configs/config.dart';
import '../../models/CateModel.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  void initState() { 
    super.initState();
    _getLeftCateData();
  }

  _getLeftCateData() async {
    var api = '${Config.apiUrl}api/pcate';

    var response = await Dio().get(api);

    // print(focusData.data is Map);

    var leftCateList = CateModel.fromJson(response.data);

    // print(focusList.result);

    // focusList.result.forEach((value){
    //   print(value.title);
    //   print(value.pic);
    // });

    setState(() {
      this._leftCateList = leftCateList.result;
    });

    this._getRightCateData(this._leftCateList[this._selectIndex].sId);
  }

  _getRightCateData(pid) async {
    var api = '${Config.apiUrl}api/pcate?pid=${pid}';
     var response = await Dio().get(api);

    // print(focusData.data is Map);

    var rightCateList = CateModel.fromJson(response.data);

    // print(focusList.result);

    // focusList.result.forEach((value){
    //   print(value.title);
    //   print(value.pic);
    // });

    setState(() {
      this._rightCateList = rightCateList.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 右侧宽度
    var leftWidth = ScreenAdaper.getScreenWidth() / 4;
    // 右侧宽度=总宽度-左侧宽度-GridView外侧原生padding值-GridView中间的间距
    var rightItemWidth =
        (ScreenAdaper.getScreenWidth() - leftWidth - 20 - 20) / 3;
    rightItemWidth = ScreenAdaper.width(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenAdaper.height(28);
    // 左侧组件
    Widget _leftCateWidget(leftWidth) {
      if (this._leftCateList.length > 0) {
        return Container(
          width: leftWidth,
          height: double.infinity,
          child: ListView.builder(
            itemCount: this._leftCateList.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = index;
                      });
                      this._getRightCateData(this._leftCateList[index].sId); 
                    },
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdaper.height(84),
                      padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                      child: Text("${this._leftCateList[index].title}"),
                      color: _selectIndex == index ? Color.fromRGBO(240, 246, 246, 0.9) : Colors.white,
                    ),
                  ),
                  Divider(
                    height: 1,
                  )
                ],
              );
            },
          ),
        );
      } else {
        return Container(
          width: leftWidth,
          height: double.infinity,
          child: Text("加载中..."),
        );
      }
    }

    // 右侧组件
    Widget _rightCateWidget(rightItemWidth,rightItemHeight) {
      if (this._rightCateList.length > 0) {
        return           Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              height: double.infinity,
              color: Color.fromRGBO(240, 246, 246, 0.9),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: rightItemWidth / rightItemHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: this._rightCateList.length,
                itemBuilder: (context, index) {
                  String pic = this._rightCateList[index].pic;
                  pic = Config.apiUrl+pic.replaceAll('\\', '/');
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/productList',arguments: {
                        "cid":this._rightCateList[index].sId,
                      });
                    },
                    child: Container(
                    //  padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            "${pic}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: ScreenAdaper.height(35),
                          child: Text("${this._rightCateList[index].title}"),
                        ),
                      ],
                    ),
                  ),
                  );
                },
              ),
            ),
          );

      } else {
        return  Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              height: double.infinity,
              color: Color.fromRGBO(240, 246, 246, 0.9),
              child: Text("加载中..."),
            )
        );
      }
    }
    return Container(
      child: Row(
        children: <Widget>[
          _leftCateWidget(leftWidth),
          _rightCateWidget(rightItemWidth,rightItemHeight),
        ],
      ),
    );
  }
}
