import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/pages/logInPage.dart';
import 'package:spashta_base_app/pages/switchConnections.dart';
import 'package:spashta_base_app/styling/textStyles.dart';

class ConnectionForm extends StatefulWidget {
  const ConnectionForm({Key? key}) : super(key: key);

  @override
  _ConnectionFormState createState() => _ConnectionFormState();
}

class _ConnectionFormState extends State<ConnectionForm> {
  GlobalKey<FormState> connectionFormKey = GlobalKey<FormState>();
  TextEditingController urlController = TextEditingController();
  TextEditingController aliasController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  List<String> moduleList = ["idm"];

  Future<Null> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    config = {"URL": baseURL, "Division": division, "Module": module};
    String encodedConfig = json.encode(config);
    prefs.setString("Alias", alias!);
    aliasNames.contains(alias)
        ? aliasNames = aliasNames
        : aliasNames.add(alias!);
    prefs.setStringList("AliasNames", aliasNames);
    prefs.setString(genKey(alias!), encodedConfig);
  }

  String genKey(String input) {
    return input + 'config';
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
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 35.0, right: 35.0, top: 30.0),
              child: Container(
                decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
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
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        child: Text('Create Workspace', style: titleTextStyle),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => SwitchConnections()));
                          },
                          child: Text('Already have a workspace? Click here.',
                              style: optionsTextStyle)),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0.0,
                              bottom: 10.0,
                              left: 20.0,
                              right: 20.0,
                            ),
                            child: TextFormField(
                              controller: aliasController,
                              validator: (val) => val!.isEmpty
                                  ? 'Please enter an alias.'
                                  : null,
                              decoration: InputDecoration(
                                hintText: 'Alias name',
                                hintStyle: hintTextStyle,
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
                                  Icons.edit,
                                  size: 20.0,
                                  color: dark,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: TextFormField(
                              controller: urlController,
                              validator: (url) => url!.isEmpty
                                  ? 'Please enter a valid URL.'
                                  : null,
                              decoration: InputDecoration(
                                hintText: 'URL',
                                hintStyle: hintTextStyle,
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
                              vertical: 10.0,
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
                                hintStyle: hintTextStyle,
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
                                hintStyle: hintTextStyle,
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
                                    alias = aliasController.text;
                                    baseURL = urlController.text;
                                    division = divisionController.text;
                                  });
                                  save();
                                  Navigator.of(context).push(
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
