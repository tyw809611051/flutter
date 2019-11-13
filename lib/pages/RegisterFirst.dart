import 'package:flutter/material.dart';
import '../widgets/JdText.dart';
import '../widgets/JdButton.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册第一步"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30,),
          JdText(
               text: "请输入手机号",
               onChanged: (value) {
                 print(value);
               },
             ),
          SizedBox(height: 20,),
          JdButton(
               text: "下一步",
               color: Colors.red,
               cb: () {
                 Navigator.pushNamed(context, '/registerSecond');
               },
             ),
        ],
      ),
    );
  }
}