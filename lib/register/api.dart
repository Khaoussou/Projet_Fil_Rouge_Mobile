import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gestion_school_odc/model/cours.dart';
import 'package:gestion_school_odc/model/session.dart';
import 'package:gestion_school_odc/model/user.dart';
import 'package:http/http.dart' as http;

class Api {
  final String _url = "http://192.168.1.14:8000/api/";
  final storage = const FlutterSecureStorage();

  login(data, endPont) async {
    var fullUrl = _url + endPont;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeadersLogin());
  }

  logout(endPoint) async {
    var fullUrl = _url + endPoint;
    String token = await getToken();

    return http
        .get(Uri.parse(fullUrl), headers: {'Authorization': 'Bearer $token'});
  }

  getToken() async {
    var json = await storage.read(key: 'user');
    var user = User.fromJson(jsonDecode(json!));
    return user.token;
  }

  getUserConnect() async {
    var json = await storage.read(key: 'user');
    var user = User.fromJson(jsonDecode(json!));
    return user;
  }

  getUserCours(endPoint, userId) async {
    try {
      http.Response response =
          await http.get(Uri.parse("$_url$endPoint/$userId"));

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        CoursResponse coursResponse = CoursResponse.fromJson(data);
        return coursResponse;
      } else {
        throw Exception('error-> ${jsonDecode(response.body)}');
      }
    } catch (e) {
      print(e);
    }
  }

  getUserSession(endPoint, userId, courId) async {
    try {
      http.Response response =
          await http.get(Uri.parse("$_url$endPoint/$userId/$courId"));

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        SessionResponse sessionResponse = SessionResponse.fromJson(data);
        return sessionResponse;
      } else {
        throw Exception('error-> ${jsonDecode(response.body)}');
      }
    } catch (e) {
      print(e);
    }
  }

  getSessionDay(endPoint, userId) async {
    try {
      http.Response response =
          await http.get(Uri.parse("$_url$endPoint/$userId"));

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        SessionResponse sessionResponse = SessionResponse.fromJson(data);
        return sessionResponse;
      } else {
        throw Exception('error-> ${jsonDecode(response.body)}');
      }
    } catch (e) {
      print(e);
    }
  }

  registration(data, endPont) async {
    var fullUrl = _url + endPont;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeadersLogin());
  }

  _setHeadersLogin() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
}
