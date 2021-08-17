import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/pages/logInPage.dart';
import 'package:spashta_base_app/styling/textStyles.dart';

class SwitchConnections extends StatefulWidget {
  const SwitchConnections({Key? key}) : super(key: key);

  @override
  _SwitchConnectionsState createState() => _SwitchConnectionsState();
}

class _SwitchConnectionsState extends State<SwitchConnections> {
  int? selectedTile;

  @override
  void initState() {
    getAliases();
    super.initState();
  }

  Future<void> setConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Alias", alias!);
    String? encodedConfig = prefs.getString(genKey(alias!));
    config = json.decode(encodedConfig!);
    setState(() {
      baseURL = config!["URL"];
      module = config!["Module"];
      division = config!["Division"];
    });
  }

  Future<void> getAliases() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aliasNames = prefs.getStringList("AliasNames")!;
    });
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("Username");
    await prefs.remove("SessionID");
  }

  String genKey(String input) {
    return input + 'config';
  }

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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermark.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset.zero,
                              blurRadius: 5.0)
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 40.0, bottom: 30.0),
                            child: Text('Select a Workspace',
                                textAlign: TextAlign.center,
                                style: titleTextStyle),
                          ),
                          aliasNames.length == 0
                              ? Text(
                                  'Sorry! Seems like you do not have any workspaces saved.',
                                  textAlign: TextAlign.center,
                                  style: messageTextStyle)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: aliasNames.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      margin: EdgeInsets.only(
                                          left: 0.0,
                                          top: 7.5,
                                          bottom: 7.5,
                                          right: 20.0),
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15.0),
                                              bottomRight:
                                                  Radius.circular(15.0))),
                                      color: dark,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: light,
                                            disabledColor: light),
                                        child: RadioListTile(
                                          value: index,
                                          groupValue: selectedTile,
                                          onChanged: (int? val) {
                                            setState(() {
                                              selectedTile = val!;
                                              alias = aliasNames[val];
                                            });
                                          },
                                          activeColor: light,
                                          // selected: true,
                                          title: Text(aliasNames[index],
                                              style: dataTitleTextStyle),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          aliasNames.length == 0
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25.0, bottom: 20.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      primary: dark,
                                      minimumSize: Size(70.0, 70.0),
                                      shadowColor: dark,
                                      elevation: 5.0,
                                    ),
                                    onPressed: () {
                                      if (selectedTile != null) {
                                        logout();
                                        setConfig();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        LogInPage()),
                                                (route) => false);
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
                    ),
                  ),
                ),
                // Expanded(child: Container())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
