import 'package:flutter/material.dart';
import 'package:spashta_base_app/models/login.dart';
import 'package:spashta_base_app/widgets/progressHUD.dart';
import 'package:spashta_base_app/services/api_login_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  LoginRequestModel? requestModel;
  bool isAPICall = false;
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel(
      user: userController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: loginUI(context),
        inAsyncCall: isAPICall,
        opacity: 0.5,
        color: Colors.blue.shade100);
  }

  Widget loginUI(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Welcome to Spashta!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                          color: Colors.white,
                          offset: Offset.zero,
                          blurRadius: 10.0)
                    ],
                    fontSize: 40.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.0,
                    height: 1.0,
                    fontFamily: 'Poppins',
                    color: Color(0xFF231F20),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, bottom: 30.0, top: 30.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF231F20),
                          offset: Offset.zero,
                          blurRadius: 10.0)
                    ]),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xFF231F20),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 25.0,
                              letterSpacing: 0.0,
                              height: 1.0,
                              shadows: [
                                Shadow(
                                    color: Colors.white,
                                    offset: Offset.zero,
                                    blurRadius: 2.0)
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 25.0,
                                bottom: 5.0,
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: TextFormField(
                                controller: userController,
                                validator: (username) => username!.isEmpty
                                    ? 'Please enter a username.'
                                    : null,
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(35, 31, 32, 0.5),
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    height: 1.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF231F20), width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF231F20), width: 2.0),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 20.0,
                                    color: Color(0xFF231F20),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                                bottom: 125.0,
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: TextFormField(
                                obscureText: hidePassword,
                                controller: passwordController,
                                validator: (password) => password!.isEmpty
                                    ? 'Please enter a password.'
                                    : null,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(35, 31, 32, 0.5),
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    height: 1.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF231F20), width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF231F20), width: 2.0),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    size: 20.0,
                                    color: Color(0xFF231F20),
                                  ),
                                  suffixIcon: IconButton(
                                    color: Color.fromRGBO(35, 31, 32, 0.5),
                                    focusColor: Color(0xFF231F20),
                                    icon: Icon(
                                      hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Color(0xFF231F20),
                            minimumSize: Size(70.0, 70.0),
                            shadowColor: Color(0xFF231F20),
                            elevation: 10.0,
                          ),
                          onPressed: () {
                            if (validateAndSave()) {
                              setState(() {
                                isAPICall = true;
                              });
                              requestModel!.json = "{\"user\":\"" +
                                  userController.text +
                                  "\",\"password\":\"" +
                                  passwordController.text +
                                  "\",\"module\":\"idm\"}";
                              LoginService loginService = LoginService();
                              loginService.login(requestModel!).then((value) {
                                setState(() {
                                  isAPICall = false;
                                });
                              });
                              print(requestModel!.toJson());
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 35.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
