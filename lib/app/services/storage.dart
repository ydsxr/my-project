import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  //设置数据(dynamic：运行时确定的类型，可以转变为任意类型)
  static setData(String key, dynamic value) async {
    // 初始化对象
    var prefs = await SharedPreferences.getInstance();
    // key是写入的目录
    prefs.setString(key, json.encode(value));
  }

  // 获取数据，根据key获取value
  static getData(String key) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String? tempData = prefs.getString(key);
      if (tempData != null) {
        return json.decode(tempData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

//删除数据
  static removeData(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

//清空数据
  static clear(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
