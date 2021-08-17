import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardResponseModel {
  String? title;
  List<Response>? responses;
  String? type;
  int? statusCode;

  DashboardResponseModel(
      {this.title, this.responses, this.type, this.statusCode});

  factory DashboardResponseModel.fromJson(http.Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return DashboardResponseModel(
        title: json["title"],
        responses: List<Response>.from(
            json["responses"].map((x) => Response.fromJson(x))),
        type: json["type"],
        statusCode: 200);
  }
}

class Response {
  List<Rows>? rows;
  String? type;
  Schema? schema;

  Response({this.rows, this.type, this.schema});

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        rows: List<Rows>.from(json["rows"].map((x) => Rows.fromJson(x))),
        type: json["type"],
        schema: Schema.fromJson(json["schema"]),
      );
}

class Rows {
  List<String>? cells;

  Rows({this.cells});

  factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        cells: List<String>.from(json["cells"].map((x) => x)),
      );
}

class Schema {
  String? title;
  List<Header>? header;

  Schema({this.title, this.header});

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
        title: json["title"],
        header:
            List<Header>.from(json["header"].map((x) => Header.fromJson(x))),
      );
}

class Header {
  String? displayName;

  Header({this.displayName});

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        displayName: json["displayName"],
      );
}
