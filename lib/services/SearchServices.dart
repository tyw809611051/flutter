import 'dart:convert';

import '../services/Storage.dart';

class SearchServices {
  static setHistoryList(value) async {

    try {
      List searchListData = json.decode(await Storage.getString('searchList'));

      var hasData = searchListData.any( (val) {
        return val == value;
      });

      if (!hasData) {
        searchListData.add(value);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } catch(e) {
      List tempList = new List();
      tempList.add(value);

      await Storage.setString('searchList', json.encode(tempList));
    }
    
  }

  static getHistoryList() async {
    try {
      List searchListData = json.decode(await Storage.getString('searchList'));

      return searchListData;
    } catch(e) {
      return [];
    }
  }

  static removeHistoryList() async {
    await Storage.remove("searchList");
  }
}