import 'package:flutter/material.dart';
import 'package:spashta_base_app/widgets/loginForm.dart';
import 'package:spashta_base_app/styling/textStyles.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(20.0))),
          toolbarHeight: 100.0,
          leading: Image.asset('assets/images/logo.png'),
          title: Text('Welcome to Spashta! ', style: welcomeAppBarTextStyle),
          centerTitle: true,
        ),
        body: LoginForm(),
      ),
    );
  }
}
