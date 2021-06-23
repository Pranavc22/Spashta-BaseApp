import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spashta_base_app/models/menu.dart';
import 'package:spashta_base_app/constants.dart';

class MenuService {
  Future<MenuResponseModel> getMenu(MenuRequestModel menuRequestModel) async {
    String url = 'http://' + baseURL + '/spashta/api/menu/mobile';
    Map<String, String> postHeaders = {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json;charset=UTF-8',
      'Transfer-Encoding': 'chunked'
    };
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(menuRequestModel.toJson()), headers: postHeaders);
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      print('Menu Response status code is: ${response.statusCode}.');
      return MenuResponseModel.fromJson(response);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data.');
    }
  }
}
