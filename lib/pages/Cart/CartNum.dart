import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartNum extends StatefulWidget {
  CartNum({Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Container(
      width: ScreenAdaper.width(165),
      decoration: BoxDecoration(
          border: Border.all(
        width: 1,
        color: Colors.black12,
      )),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn(),
        ],
      ),
    );
  }

  // 左侧按钮
  Widget _leftBtn() {
    return InkWell(
      child: Container(
        height: ScreenAdaper.height(45),
        width: ScreenAdaper.width(45),
        alignment: Alignment.centerRight,
        child: Text("-"),
      ),
    );
  }

  // 右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: () {

      },
      child: Container(
        height: ScreenAdaper.height(45),
        width: ScreenAdaper.width(45),
        alignment: Alignment.centerRight,
        child: Text("+"),
      ),
    );
  }

  // 中间区域
  Widget _centerArea() {
    return Container(
      height: ScreenAdaper.height(70),
      width: ScreenAdaper.width(45),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: 1, color: Colors.black12),
              right: BorderSide(width: 1, color: Colors.black12))),
      child: Text("1"),
    );
  }
}
