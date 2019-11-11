import 'dart:developer';

import 'package:flutter/material.dart';
import 'routers/router.dart';
import 'package:provider/provider.dart';
import './provider/Cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( builder: (_) => Cart(),)
      ],
      child: MaterialApp(
        //  home: Tabs()
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
//      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}
