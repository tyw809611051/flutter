import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cartProvider.addList('哈哈${cartProvider.cartNum}');
        },
      ),
      body: Column(
        children: <Widget>[
          CartItem(),
          Divider(height: 40,),
          CartNum(),
        ],
      ),
    );
  }
}