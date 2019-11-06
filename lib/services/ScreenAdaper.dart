import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
 * 封装屏幕适配类
 */
class ScreenAdaper {

  static init(context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }

  // 获取适配后的高度
  static height(double value) {
    return ScreenUtil.getInstance().setHeight(value);
  }

  // 获取适配后的宽度
  static width(double value) {
    return ScreenUtil.getInstance().setWidth(value);
  }

  // 当前设备高度 dp
  static getScreenHeight() {
    return ScreenUtil.screenHeightDp;
  }

  // 当前设备宽度 dp
  static getScreenWidth() {
    return ScreenUtil.screenWidthDp;
  }
}