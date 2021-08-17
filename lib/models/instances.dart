import 'dart:convert';
import 'package:http/http.dart';

class InstancesRequestModel {
  String? instruction;
  int? sessionId;
  String? json;

  InstancesRequestModel({this.instruction, this.sessionId, this.json});

  Map<String, dynamic> toJson() => {
        "instruction": "PERFORM_QUERY",
        "sessionId": sessionId,
        "json": json,
      };
}

class InstancesResponseModel {
  List<String>? values;
  int? statusCode;

  InstancesResponseModel({this.values, this.statusCode});

  factory InstancesResponseModel.fromJson(Response response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return InstancesResponseModel(
          values: List<String>.from(json["values"].map((x) => x)),
          statusCode: 200);
    } else
      return InstancesResponseModel(statusCode: response.statusCode);
  }
}
