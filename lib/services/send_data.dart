import 'dart:convert';

import 'package:http/http.dart' as http;

class SendData {
  Future<http.Response> goPost(String url, Object object) async {
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(object));

    return response;
  }
}
