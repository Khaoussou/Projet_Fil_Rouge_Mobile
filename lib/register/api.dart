import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String _url = "http://192.168.1.255:8000/api/";

  postData(data, endPont) async {
    var fullUrl = _url + endPont;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
}
