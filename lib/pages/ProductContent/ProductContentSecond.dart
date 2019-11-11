import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import '../../configs/config.dart';

class ProductContentSecond extends StatefulWidget {
  final List _productContentList;
  ProductContentSecond(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> with AutomaticKeepAliveClientMixin {
  var _id;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();

    this._id = widget._productContentList[0].sId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
           Expanded(
             child: InAppWebView(
                    initialUrl: "${Config.apiUrl}pcontent?id=${this._id}",
                    initialHeaders: {

                    },
                    initialOptions: {

                    },
                  ),
           ),
        ],
      ),
    );
  }
}
