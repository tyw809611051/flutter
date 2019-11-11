import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';

class JdButton extends StatelessWidget {
  final Color color;
  final String text;
  final Object cb;

  JdButton({Key key, this.color=Colors.black, this.text="按钮", this.cb=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      child: InkWell(
        onTap: this.cb,
        child: Container(
          height: ScreenAdaper.height(76),
          width: double.infinity,
          decoration: BoxDecoration(
              color: this.color,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              "${this.text}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
