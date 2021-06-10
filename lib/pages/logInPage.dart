import 'package:flutter/material.dart';
import 'package:spashta_base_app/widgets/loginForm.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoginForm(),
      ),
    );
  }
}
