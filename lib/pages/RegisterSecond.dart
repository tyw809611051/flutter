import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/JdText.dart';
import '../widgets/JdButton.dart';
import '../configs/config.dart';

class RegisterSecondPage extends StatefulWidget {
  Map arguments;
  RegisterSecondPage({Key key, this.arguments}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  String tel;
  bool sendCodeButton = false;
  int seconds = 10;
  String code;
  @override
  void initState() {
    super.initState();
    this.tel = widget.arguments['tel'];
    this.showTimer();
  }

  showTimer() {
    Timer t;
    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        this.seconds--;
      });
      if (this.seconds == 0) {
        t.cancel();
        this.sendCodeButton = true;
      }
    });
  }

  // 重新发送
  sendCode() async {
    var api = "${Config.apiUrl}api/sendCode";

    var response = await Dio().post(api, data: {
      "tel": this.tel,
    });

    if (response.data['success']) {
      print(response.data);
      // Navigator.pushNamed(context, '/registerSecond',arguments: {
      //   "tel":this.tel,
      // });
      setState(() {
        this.sendCodeButton = false;
        this.seconds = 10;
        this.showTimer();
      });
    } else {
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  // 验证验证码
  validateCode() async{
    var api = "${Config.apiUrl}api/validateCode";

    var response = await Dio().post(api, data: {
      "tel": this.tel,
      "code": this.code,
    });

    if (response.data['success']) {
      Navigator.pushNamed(context, '/registerThird',arguments: {
        "tel": this.tel,
        "code": this.code,
      });
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
          title: Text("2"),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text("验证码已发送到${this.tel}"),
              ),
              Stack(
                children: <Widget>[
                  JdText(
                    text: "请输入验证码",
                    onChanged: (value) {
                      this.code=value;
                      print(value);
                    },
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: this.sendCodeButton
                        ? RaisedButton(
                            onPressed: this.sendCode,
                            child: Text("重新发送"),
                          )
                        : RaisedButton(
                            onPressed: () {},
                            child: Text("${this.seconds}秒后重发"),
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              JdButton(
                text: "下一步",
                color: Colors.red,
                cb: this.validateCode,
              ),
            ],
          ),
        ));
  }
}
