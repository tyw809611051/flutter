import 'package:flutter/material.dart';
import 'package:flutter_cisslab/pages/ProductList.dart'; 
import '../pages/tabs/Tabs.dart';
import '../pages/ProductList.dart';
//配置路由 
final routes={ 
  '/': (context) => Tabs(),
  '/productList': (context,{arguments}) => ProductList(arguments:arguments) ,
}; 

var onGenerateRoute = (RouteSettings settings){
  // 统一处理 
  final String name=settings.name;
  final Function pageContentBuilder=routes[name]; 
  if(pageContentBuilder!=null){ 
    if(settings.arguments!=null){
      final Route route=MaterialPageRoute( 
        builder:(context)=> pageContentBuilder(context,arguments:settings.arguments)
      ); 
      return route; 
    } else {
      final Route route=MaterialPageRoute( 
        builder:(context)=> pageContentBuilder(context)
      ); 
      return route;
    }
  }
};

