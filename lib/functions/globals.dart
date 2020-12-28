import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/global.dart';

server() async {
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return jsonData;
  }
}
