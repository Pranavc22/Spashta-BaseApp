import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spashta_base_app/models/table.dart';
import 'package:spashta_base_app/models/dashboard.dart';
import 'package:spashta_base_app/models/query.dart';
import 'package:spashta_base_app/constants.dart';

class QueryService {
  Future getQuery(QueryRequestModel queryRequestModel) async {
    String url = 'http://' + baseURL + '/spashta/api/query';
    Map<String, String> postHeaders = {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json;charset=UTF-8',
      'Transfer-Encoding': 'chunked'
    };
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(queryRequestModel.toJson()), headers: postHeaders);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json["type"] == "MULTI")
        return DashboardResponseModel.fromJson(response);
      else if (json["type"] == "TABLE")
        return TableResponseModel.fromJson(response);
      else
        return QueryResponseModel.fromJson(response);
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 500) {
      return QueryResponseModel.fromJson(response);
    } else {
      print("ERROR. Query Response Code: ${response.statusCode}");
      throw Exception('Failed to load data.');
    }
  }
}
