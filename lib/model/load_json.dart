import 'dart:convert';
import 'dart:core';

import 'package:flutter/services.dart' show rootBundle;

class LoadJson {
  static const String JSONData = 'assets/json/video.json';

  static Future<dynamic> loadJson(String jsonFile) async {
    // 取得資料
    String data = await rootBundle.loadString(jsonFile);
    // String Data轉換成json物件
    var jsonObject = jsonDecode(data);
    return jsonObject;
  }
}
