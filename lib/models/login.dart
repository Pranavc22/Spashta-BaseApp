class LoginRequestModel {
  String? instruction;
  int? sessionId;
  String? user;
  String? password;
  String? json;

  LoginRequestModel({this.user, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "instruction": "LOGIN",
      "sessionId": 0,
      "json": json
    };
    return map;
  }
}

class LoginResponseModel {
  final int? sessionId;

  LoginResponseModel({this.sessionId});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(sessionId: json["sessionId"]);
}
