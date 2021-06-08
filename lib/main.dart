import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spashta_base_app/pages/logIn.dart';

void main() => runApp(BaseApp());

class BaseApp extends StatelessWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue.shade200,
          accentColor: Color(0xFF231F20)),
      home: LogIn(),
    );
  }
}

//TODO: Get high res pictures, if possible.
//TODO: Add validation for username, in case there is a specific format.
