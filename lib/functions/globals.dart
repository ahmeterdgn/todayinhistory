import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/global.dart';

server(type) async {
  var response = await http.get(url + type + ".json");
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(response);
    return jsonData;
  }
}
