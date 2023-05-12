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
    String pre = "generate a summary on, ";
    String finalData = pre + data;
    
    // print(data);
    // final url = Uri.parse("http://192.168.145.216:9000/getsummary");//https://api.openai.com/v1/chat/completions
    final url = Uri.parse(
        "https://api.openai.com/v1/chat/completions"); //https://api.openai.com/v1/chat/completions

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer " + urlGetter.accessToken,
        "Content-Type": "application/json"
      },
      body: json.encode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": finalData.toString()}
          ],
        },
      ),
    );
    if (response.body == 'null') {
      return;
    }
    print(response.body);

    // print();

    final responseData = json.decode(response.body);
    // print(response.body);
    String result =
        responseData['choices'][0]["message"]["content"]; //[{},{},{}]
    print(result);
    ans = result;
    print(ans);

    notifyListeners();
  }
}
