import 'package:flutter/material.dart';
import 'package:flutter_cisslab/services/ScreenAdaper.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: ScreenAdaper.height(220),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/hot.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ClipOval(
                    child: Image.asset(
                      "lib/assets/images/hot.jpg",
                      fit: BoxFit.cover,
                      width: ScreenAdaper.width(100),
                      height: ScreenAdaper.height(100),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("注册/登录",style: TextStyle(
                    color: Colors.white
                  ),),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text("用户名：12445534",style:TextStyle(
                //         color: Colors.white,
                //         fontSize: ScreenAdaper.size(32),
                //       )),
                //       Text("普通会员",style: TextStyle(
                //         color: Colors.white,
                //         fontSize: ScreenAdaper.size(24),
                //       ),)
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text("订单列表"),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            title: Text("已付款"),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.yellow,
            ),
            title: Text("未付款"),
          ),
          Divider(),
          Container(
            width: double.infinity,
            height: 20,
            color: Colors.black12,
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            title: Text("已付款"),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.yellow,
            ),
            title: Text("未付款"),
          ),
          Divider(),
        ],
      ),
    );
  }
}
