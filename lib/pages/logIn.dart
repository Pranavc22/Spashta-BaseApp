import 'package:flutter/material.dart';
import 'package:spashta_base_app/widgets/loginForm.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermark.png'),
                fit: BoxFit.cover),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
