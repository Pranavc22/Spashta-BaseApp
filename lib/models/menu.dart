import 'dart:convert';
import 'package:http/http.dart';

class MenuRequestModel {
  String? instruction;
  int? sessionid;
  String? json;

  MenuRequestModel({this.instruction, this.sessionid, this.json});

  Map<String, dynamic> toJson() =>
      {"instruction": "PERFORM_QUERY", "sessionId": sessionid, "json": json};
}

class MenuResponseModel {
  List<MenuChild>? children;
  int? statusCode;

  MenuResponseModel({this.children, this.statusCode});

  factory MenuResponseModel.fromJson(Response response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return MenuResponseModel(
          statusCode: 200,
          children: List<MenuChild>.from(
              json["children"].map((i) => MenuChild.fromJson(i))));
    } else
      return MenuResponseModel(statusCode: response.statusCode);
  }
}

class MenuChild {
  String? name;
  List<MenuChildChild>? children;

  MenuChild({this.name, this.children});

  factory MenuChild.fromJson(Map<String, dynamic> json) => MenuChild(
      name: json["name"],
      children: List<MenuChildChild>.from(
          json["children"].map((i) => MenuChildChild.fromJson(i))));
}

class MenuChildChild {
  String? name;
  String? actionId;

  MenuChildChild({this.name, this.actionId});

  factory MenuChildChild.fromJson(Map<String, dynamic> json) =>
      MenuChildChild(name: json["name"], actionId: json["actionId"]);
}
