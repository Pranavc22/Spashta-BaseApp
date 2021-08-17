import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spashta_base_app/models/login.dart';
import 'package:spashta_base_app/constants.dart';

class LoginService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://" + baseURL + "/spashta/api/login";
    Map<String, String> postHeaders = {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json;charset=UTF-8',
      'Transfer-Encoding': 'chunked'
    };
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(requestModel.toJson()), headers: postHeaders);
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      print('Login status code is: ${response.statusCode}.');
      return LoginResponseModel.fromJson(response);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data.');
    }
  }
}
