import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minuteofmeeting/models/url.dart';

class summaryProvider with ChangeNotifier {
  String ans = "";

  String get getans {
    return ans;
  }

  Future<void> detectSummary({required String data}) async {
    // print(data);
    final url = Uri.parse("http://192.168.145.216:9000/getsummary");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          'data': data,
        },
      ),
    );
    if (response.body == 'null') {
      return;
    }

    final responseData = json.decode(response.body);
    String result = responseData['result']; //[{},{},{}]
    ans = result;
    print(ans);

    notifyListeners();
  }
}
