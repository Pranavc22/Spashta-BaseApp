import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/pages/logInPage.dart';
import 'package:spashta_base_app/widgets/dashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(25.0))),
          toolbarHeight: 70.0,
          leading: Image.asset('assets/images/logo.png'),
          title: Text(
            'Welcome back, ' + name,
            style: TextStyle(
                color: light,
                fontSize: 16.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                  setState(() {
                    isLoggedIn = false;
                    name = '';
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(builder: (context) => LogInPage()),
                      (route) => false);
                },
                icon: Icon(
                  Icons.logout,
                  color: light,
                  size: 20.0,
                ))
          ],
        ),
        body: Dashboard(),
      ),
    );
  }
}
