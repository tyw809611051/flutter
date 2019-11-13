import 'package:flutter/material.dart';
import 'package:flutter_cisslab/services/ScreenAdaper.dart';
import '../widgets/JdText.dart';
import '../widgets/JdButton.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           leading: IconButton(
             icon: Icon(Icons.close),
             onPressed: () {
               Navigator.pop(context);
             },
           ),
          //  title: Text("登录页面"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text("客服"),
            ),
          ],
         ),
         body: Container(
           padding: EdgeInsets.all(20),
           child: ListView(
           children: <Widget>[
             Center(
               child: Container(
                 margin: EdgeInsets.only(top: 30),
                 height: ScreenAdaper.height(160),
                 width: ScreenAdaper.width(160),
                 child: Image.network("https://www.itying.com/images/flutter/list5.jpg",fit: BoxFit.cover),
               ),
             ),
             SizedBox(height: 30,),
             JdText(
               text: "请输入用户名",
               onChanged: (value) {
                 print(value);
               },
             ),
             SizedBox(height: 10,),
             JdText(
               text: "请输入密码",
               password: true,
               onChanged: (value) {
                 print(value);
               },
             ),
             SizedBox(height: 20,),
             Container(
               padding: EdgeInsets.all(10),
               child: Stack(
                 children: <Widget>[
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text("忘记密码"),
                   ),
                   Align(
                     alignment: Alignment.centerRight,
                     child: Text("新用户注册"),
                   ),
                 ],
               ),
             ),
             JdButton(
               text: "登录",
               color: Colors.red,
               cb: () {

               },
             ),
           ],
         ),
         ),
       ),
    );
  }
}