import 'dart:convert';
import 'package:http/http.dart';

class ReplicasRequestModel {
  String? instruction;
  int? sessionId;
  String? json;

  ReplicasRequestModel({this.instruction, this.sessionId, this.json});

  Map<String, dynamic> toJson() => {
        "instruction": "PERFORM_QUERY",
        "sessionId": sessionId,
        "json": json,
      };
}

class ReplicasResponseModel {
  List<String>? values;
  int? statusCode;

  ReplicasResponseModel({this.values, this.statusCode});

  factory ReplicasResponseModel.fromJson(Response response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return ReplicasResponseModel(
          values: List<String>.from(json["values"].map((x) => x)),
          statusCode: 200);
    } else
      return ReplicasResponseModel(statusCode: response.statusCode);
  }
}
