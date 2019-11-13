import 'package:flutter/material.dart';
import 'package:flutter_cisslab/services/ScreenAdaper.dart';

class JdText extends StatelessWidget {

  String text;
  bool password;
  Object onChanged;
  JdText({Key key,this.text="输入内容",this.password=false,this.onChanged=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdaper.height(68),
      decoration: BoxDecoration(
        // color: Color.fromRGBO(233, 233, 233, 0.8),
        // borderRadius: BorderRadius.circular(30),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: TextField(
        // autofocus: true,
        obscureText: this.password,
        decoration: InputDecoration(
          hintText: this.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          )
        ),
        onChanged: this.onChanged,
      ),
    );
  }
}