import 'package:flutter/material.dart';
import './CartNum.dart';
import '../../services/ScreenAdaper.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Container(
      height: ScreenAdaper.height(160),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 1,
          color: Colors.black12,
        ),
      )),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdaper.width(60),
            child: Checkbox(
              value: true,
              onChanged: (value) {},
              activeColor: Colors.pink,
            ),
          ),
          Container(
            width: ScreenAdaper.width(160),
            child: Image.network(
                "https://www.itying.com/images/flutter/list2.jpg",
                fit: BoxFit.cover),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "哈哈哈哈哈哈",
                    maxLines: 2,
                  ),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("¥55",style: TextStyle(color: Colors.red),),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
