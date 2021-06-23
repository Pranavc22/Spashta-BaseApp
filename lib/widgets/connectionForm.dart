import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/pages/logInPage.dart';

class ConnectionForm extends StatefulWidget {
  const ConnectionForm({Key? key}) : super(key: key);

  @override
  _ConnectionFormState createState() => _ConnectionFormState();
}

class _ConnectionFormState extends State<ConnectionForm> {
  GlobalKey<FormState> connectionFormKey = GlobalKey<FormState>();
  TextEditingController urlController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  List<String> moduleList = ["idm"];

  Future<Null> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('URL', baseURL);
    prefs.setString('Division', division);
    prefs.setString('Module', module!);
  }

  bool valid() {
    final form = connectionFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/watermark.png'),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, bottom: 30.0, top: 30.0),
              child: Container(
                decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset.zero,
                          blurRadius: 5.0)
                    ]),
                child: Form(
                  key: connectionFormKey,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                        child: Text(
                          'Create a Connection',
                          style: TextStyle(
                            color: dark,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            height: 1.0,
                            shadows: [
                              Shadow(
                                  color: dark,
                                  offset: Offset.zero,
                                  blurRadius: 1.0)
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 25.0,
                              bottom: 12.5,
                              left: 20.0,
                              right: 20.0,
                            ),
                            child: TextFormField(
                              controller: urlController,
                              validator: (url) => url!.isEmpty
                                  ? 'Please enter a valid URL.'
                                  : null,
                              decoration: InputDecoration(
                                hintText: 'URL',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(35, 31, 32, 0.5),
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  height: 1.0,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide:
                                      BorderSide(color: dark, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide:
                                      BorderSide(color: dark, width: 2.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.link,
                                  size: 20.0,
                                  color: dark,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.5,
                              horizontal: 20.0,
                            ),
                            child: DropdownButtonFormField(
                              value: module,
                              validator: (String? value) => value == null
                                  ? 'Please choose an option.'
                                  : null,
                              items: moduleList.map((moduleItem) {
                                return new DropdownMenuItem(
                                  child: Text(moduleItem),
                                  value: moduleItem,
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  module = newValue!;
                                });
                              },
                              dropdownColor: light,
                              decoration: InputDecoration(
                                hintText: 'Select a module',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(35, 31, 32, 0.5),
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  height: 1.0,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide:
                                      BorderSide(color: dark, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide:
                                      BorderSide(color: dark, width: 2.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.view_module,
                                  size: 20.0,
                                  color: dark,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12.5,
                              bottom: 25.0,
                              right: 20.0,
                              left: 20.0,
                            ),
                            child: TextFormField(
                              controller: divisionController,
                              validator: (division) => division!.isEmpty
                                  ? 'Please enter a valid division.'
                                  : null,
                              decoration: InputDecoration(
                                hintText: 'Division',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(35, 31, 32, 0.5),
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0,
                                  height: 1.0,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide:
                                      BorderSide(color: dark, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide:
                                      BorderSide(color: dark, width: 2.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.group,
                                  size: 20.0,
                                  color: dark,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 20.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                primary: dark,
                                minimumSize: Size(70.0, 70.0),
                                shadowColor: dark,
                                elevation: 5.0,
                              ),
                              onPressed: () {
                                if (valid()) {
                                  setState(() {
                                    baseURL = urlController.text;
                                    division = divisionController.text;
                                  });
                                  save();
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => LogInPage()));
                                }
                              },
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
