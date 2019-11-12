import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/ScreenAdaper.dart';
import '../Cart/CartItem.dart';
import '../Cart/CartNum.dart';
import '../../provider/Cart.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.launch),
            onPressed: null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cartProvider.addList('哈哈${cartProvider.cartNum}');
        },
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              CartItem()
            ],
          ),
          Positioned(
            bottom: 0,
            width: ScreenAdaper.width(750),
            height: ScreenAdaper.height(75),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Checkbox(value: true,onChanged: (val) {},activeColor: Colors.pink,),
                      Text("全选"),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    child: Text("结算",style: TextStyle(
                      color: Colors.white
                    ),),
                    color: Colors.red,
                    onPressed: () {

                    },
                    ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}