import 'package:flutter/material.dart';
import '../widgets/JdText.dart';
import '../widgets/JdButton.dart';
import '../services/ScreenAdaper.dart';

class RegisterThirdPage extends StatefulWidget {
  Map arguments;
  RegisterThirdPage({Key key,this.arguments}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String tel;
  String code;
  String password;
  String rpassword;
  @override
  void initState() { 
    super.initState();
    this.tel = widget.arguments['tel'];
    this.code = widget.arguments['code'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("3"),
      ),
      body: Container(
        child: ListView(
           children: <Widget>[

             SizedBox(height: 30,),
             JdText(
               text: "请输入密码",
               onChanged: (value) {
                 print(value);
               },
             ),
             SizedBox(height: 10,),
             JdText(
               text: "确认密码",
               password: true,
               onChanged: (value) {
                 print(value);
               },
             ),
             SizedBox(height: 20,),
             JdButton(
               text: "注册",
               color: Colors.red,
               cb: () {
                 
               },
             ),
           ],
         ),
      ),
    );
  }
}