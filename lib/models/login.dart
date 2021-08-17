import 'package:http/http.dart';
import 'dart:convert';

class LoginRequestModel {
  String? instruction;
  int? sessionId;
  String? user;
  String? password;
  String? json;

  LoginRequestModel({this.user, this.password});

  Map<String, dynamic> toJson() =>
      {"instruction": "LOGIN", "sessionId": 0, "json": json};
}

class LoginResponseModel {
  final int? sessionId;
  final int? statusCode;

  LoginResponseModel({this.sessionId, this.statusCode});

  factory LoginResponseModel.fromJson(Response response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return LoginResponseModel(sessionId: json["sessionId"], statusCode: 200);
    } else
      return LoginResponseModel(statusCode: response.statusCode);
  }
}
