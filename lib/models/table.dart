import 'dart:convert';
import 'package:http/http.dart';

class TableResponseModel {
  List<Rows>? rows;
  dynamic type;
  Schema? schema;
  int? statusCode;

  TableResponseModel({this.rows, this.type, this.schema, this.statusCode});

  factory TableResponseModel.fromJson(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return TableResponseModel(
        rows: List<Rows>.from(json["rows"].map((x) => Rows.fromJson(x))),
        type: json["type"],
        schema: Schema.fromJson(json["schema"]),
        statusCode: 200);
  }
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
