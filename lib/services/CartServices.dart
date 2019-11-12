import 'dart:convert';

import './Storage.dart';

class CartServices {
  
  static addCart(item) async {
    item = CartServices.formatCartData(item);
    try {
      List cartListData = json.decode(await Storage.getString("cartList"));

      bool hasData = cartListData.any( (val) {
        if (val['_id'] == item['_id'] && val['selectedAttr'] == item['selectedAttr']) {
          return true;
        }
      });

      if (hasData) {
        for (var i=0;i<cartListData.length;i++) {
          if (cartListData[i]['_id'] == item['_id'] && cartListData[i]['selectedAttr'] == item['selectedAttr']) {
            cartListData[i]['count'] += 1;
          }
        }

        await Storage.setString('carList',json.encode(cartListData));
      } else {
        cartListData.add(item);
        await Storage.setString('carList',json.encode(cartListData));
      }
    } catch(e) {
      List tempList = [];

      tempList.add(item);

      await Storage.setString('carList',json.encode(tempList));
    }
  }

  static formatCartData(item) {
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    data['checked'] = true;

    return data;
  }
}