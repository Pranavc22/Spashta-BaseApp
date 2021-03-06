import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spashta_base_app/pages/connectionPage.dart';
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

  Future<void> autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('Username');
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        user = userId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        accentColor: dark,
        appBarTheme: AppBarTheme(
            color: Color.fromRGBO(35, 31, 32, 0.75),
            shadowColor: Colors.black,
            elevation: 10.0),
      ),
      home: isLoggedIn ? DashboardPage() : ConnectionPage(),
      // home: LogInPage(),
    );
  }
}

/*TODO: Make official documentation. Topics that may be covered:
 - Learning Git and Github. Link to repository.
 - Learning Flutter.
 - Architecture of the project.
 - Explanation of each folder and file.
 - Testing/Publishing the app on Play Store.
 */

//TODO: Update README.md with new Resources for Week 5,6 & 7
//TODO: Provide support for Custom Dialog Box.
