import 'package:flutter/material.dart';
import '../widgets/JdText.dart';
import '../widgets/JdButton.dart';

class RegisterSecondPage extends StatefulWidget {
  RegisterSecondPage({Key key}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
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
                child: Text("请输入xxx手机收到的验证码"),
              ),
              JdText(
                text: "请输入验证码",
                onChanged: (value) {
                  print(value);
                },
              ),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("发送"),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              JdButton(
                text: "下一步",
                color: Colors.red,
                cb: () {
                  Navigator.pushNamed(context, '/registerThird');
                },
              ),
            ],
          ),
        ));
  }
}
