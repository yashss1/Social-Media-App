import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  Future register(String username,String fullName, String email, String password) async {

    Map<String, String> JsonBody = {
      'user_name':  username,
      'user_full_name': fullName,
      'user_email': email,
      'user_password': password
    };

    http.Response response = await http.post(Uri.parse(url),body: JsonBody);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
  Future login(String email, String password) async {

    Map<String, String> JsonBody = {
      'user_email': email,
      'user_password': password
    };

    http.Response response = await http.post(Uri.parse(url),body: JsonBody);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
