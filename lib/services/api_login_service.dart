import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spashta_base_app/models/login.dart';

class LoginService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://mobile.spashtasolutions.com/spashta/api/login";
    Map<String, String> postHeaders = {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json;charset=UTF-8',
      'Transfer-Encoding': 'chunked'
    };
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(requestModel.toJson()), headers: postHeaders);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print('Status code is: ${response.statusCode}.');
      print(jsonDecode(response.body));
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}