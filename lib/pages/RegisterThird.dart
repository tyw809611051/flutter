import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/JdText.dart';
import '../widgets/JdButton.dart';
import '../services/ScreenAdaper.dart';
import 'package:dio/dio.dart';
import '../configs/config.dart';
import '../services/Storage.dart';
import '../pages/tabs/Tabs.dart';

class RegisterThirdPage extends StatefulWidget {
  Map arguments;
  RegisterThirdPage({Key key, this.arguments}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String tel;
  String code;
  String password='';
  String rpassword='';
  @override
  void initState() {
    super.initState();
    this.tel = widget.arguments['tel'];
    this.code = widget.arguments['code'];
  }

  doRegister() async {
    if (this.password != rpassword) {
      Fluttertoast.showToast(
        msg: "密码和确认密码不一致",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    var api = "${Config.apiUrl}api/register";

    var response = await Dio().post(api, data: {
      "tel": this.tel,
      "code": this.code,
      "password": this.password,
    });

    if (response.data['success']) {
      Storage.setString("userInfo", json.encode(response.data['userinfo']));
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new Tabs()),
          (route) => route == null);
    } else {
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
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
            SizedBox(
              height: 30,
            ),
            JdText(
              text: "请输入密码",
              onChanged: (value) {
                this.password= value;
                print(value);
              },
            ),
            SizedBox(
              height: 10,
            ),
            JdText(
              text: "确认密码",
              password: true,
              onChanged: (value) {
                this.rpassword = value;
                print(value);
              },
            ),
            SizedBox(
              height: 20,
            ),
            JdButton(
              text: "注册",
              color: Colors.red,
              cb: doRegister,
            ),
          ],
        ),
      ),
    );
  }
}
