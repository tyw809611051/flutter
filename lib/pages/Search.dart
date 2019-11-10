import 'package:flutter/material.dart';
import '../services/SearchServices.dart';
import '../services/ScreenAdaper.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keywords;
  List _historyListData = [];

  @override
  void initState() {
    super.initState();

    this._getHistoryData();
  }

  _getHistoryData() async {
    var historyListData = await SearchServices.getHistoryList();
    setState(() {
     this._historyListData =  historyListData
     ;
    });
  }

  Widget _historyListWidget() {
    if (this._historyListData.length > 0) {
      return Column(
        children: <Widget>[
          Container(
            child: Text("历史记录", style: Theme.of(context).textTheme.title),
          ),
          Divider(),
          Column(
            children: this._historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text("${value}"),
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          ),
          SizedBox(
            height: 100,
          ),
          InkWell(
            child: Container(
              width: ScreenAdaper.width(400),
              height: ScreenAdaper.height(64),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(233, 233, 233, 0.9),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.delete),
                  Text("清空历史记录"),
                ],
              ),
            ),
            onTap: () {
              SearchServices.removeHistoryList();
              this._getHistoryData();

            },
          )
        ],
      );
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: ScreenAdaper.height(68),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              )),
              onChanged: (value) {
                this._keywords = value;
              },
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                height: ScreenAdaper.height(68),
                width: ScreenAdaper.width(80),
                child: Row(
                  children: <Widget>[Text("搜索")],
                ),
              ),
              onTap: () {
                SearchServices.setHistoryList(this._keywords);
                Navigator.pushReplacementNamed(context, '/productList',
                    arguments: {
                      "keywords": this._keywords,
                    });
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "热搜",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Divider(),
            Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("女装"),
                ),
              ],
            ),
            // 历史记录
            this._historyListWidget(),
          ],
        ),
      ),
    );
  }
}
