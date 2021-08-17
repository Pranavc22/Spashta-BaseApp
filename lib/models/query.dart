import 'package:http/http.dart';

class QueryRequestModel {
  String? instruction;
  int? sessionid;
  String? json;

  QueryRequestModel({this.instruction, this.sessionid, this.json});

  Map<String, dynamic> toJson() =>
      {"instruction": "PERFORM_QUERY", "sessionId": sessionid, "json": json};
}

class QueryResponseModel {
  String? type;
  int? statusCode;
  String? message;

  QueryResponseModel({this.type, this.statusCode, this.message});

  factory QueryResponseModel.fromJson(Response response) {
    if (response.statusCode == 400)
      return QueryResponseModel(statusCode: 400, message: "Invalid Request.");
    else if (response.statusCode == 401)
      return QueryResponseModel(
          statusCode: 401, message: "Unauthorized Access.");
    else if (response.statusCode == 500 || response.statusCode == 200)
      return QueryResponseModel(
          type: "NOT_SUPPORTED",
          statusCode: 500,
          message: "Sorry, this feature is not supported yet.");
    else
      return QueryResponseModel();
  }
}
