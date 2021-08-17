import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spashta_base_app/models/instances.dart';
import 'package:spashta_base_app/constants.dart';

class InstancesService {
  Future<InstancesResponseModel> getInstances(
      InstancesRequestModel instancesRequestModel) async {
    String url = "http://" + baseURL + "/spashta/api/instance/list";
    Map<String, String> postHeaders = {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json;charset=UTF-8',
      'Transfer-Encoding': 'chunked'
    };
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(instancesRequestModel.toJson()), headers: postHeaders);
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      print('Instances status code is: ${response.statusCode}.');
      return InstancesResponseModel.fromJson(response);
    } else {
      print(response.statusCode);
      throw Exception("Failed to load data.");
    }
  }
}
