import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/JdText.dart';
import '../widgets/JdButton.dart';
import '../configs/config.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String tel;

  sendCode() async{
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (reg.hasMatch(this.tel)) {
      var api = "${Config.apiUrl}api/sendCode";

      var response = await Dio().post(api,data: {
        "tel": this.tel,
      });

      if (response.data['success']) {
        print(response.data);
        Navigator.pushNamed(context, '/registerSecond',arguments: {
          "tel":this.tel,
        });
      } else {
        Fluttertoast.showToast(
          msg: "${response.data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      Fluttertoast.showToast(
          msg: "手机号格式错误",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册第一步"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          JdText(
            text: "请输入手机号",
            onChanged: (value) {
              this.tel = value;
              print(value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          JdButton(
            text: "下一步",
            color: Colors.red,
            cb: sendCode,
          ),
        ],
      ),
    );
  }
}
