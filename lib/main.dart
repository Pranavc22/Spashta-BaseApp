import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spashta_base_app/pages/logInPage.dart';
import 'package:spashta_base_app/pages/dashboardPage.dart';
import 'constants.dart';

void main() => runApp(BaseApp());

class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  _BaseAppState createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('Username');
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        name = userId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        accentColor: dark,
        appBarTheme: AppBarTheme(
            color: dark, shadowColor: Colors.black, elevation: 10.0),
      ),
      home: isLoggedIn ? DashboardPage() : LogInPage(),
    );
  }
}

//TODO: Get high res pictures, if possible.
//TODO: Add validation for username, in case there is a specific format.
