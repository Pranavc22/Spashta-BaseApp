import 'package:flutter/material.dart';
import 'package:spashta_base_app/pages/logIn.dart';

void main() => runApp(BaseApp());

class BaseApp extends StatelessWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn(),
    );
  }
}
