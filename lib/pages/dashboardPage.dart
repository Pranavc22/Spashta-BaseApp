import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/models/menu.dart';
import 'package:spashta_base_app/pages/connectionPage.dart';
import 'package:spashta_base_app/pages/switchConnections.dart';
import 'package:spashta_base_app/services/api_menu_service.dart';
import 'package:spashta_base_app/widgets/dashboard.dart';
import 'package:spashta_base_app/widgets/snackBars.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<MenuChild>? menuItems;
  MenuRequestModel? menuRequestModel;

  List<Widget> buildSubMenu(MenuChild menuChild) {
    List<Widget> items = [];
    for (MenuChildChild subMenuItems in menuChild.children!) {
      items.add(
        new ListTile(
          title: Text(
            subMenuItems.name!,
            style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 14.0,
                fontFamily: 'Poppins',
                color: light),
          ),
        ),
      );
    }
    return items;
  }

  Future<void> getConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    alias = prefs.getString("Alias");
    String? encodedConfig = prefs.getString(genKey(alias!));
    config = json.decode(encodedConfig!);
    setState(() {
      baseURL = config!["URL"];
      module = config!["Module"];
      division = config!["Division"];
    });

    sessionID = prefs.getInt('SessionID')!;
    menuRequestModel = new MenuRequestModel(
        sessionid: sessionID,
        json: "{\"query\":\"MAINMENU\",\"actionId\":\"mainmenu\",\"user\":\"" +
            user +
            "\",\"instance\":\"\",\"module\":\"" +
            module! +
            "\",\"division\":\"" +
            division +
            "\"}");
    MenuService menuService = MenuService();
    menuService.getMenu(menuRequestModel!).then((response) {
      print(menuRequestModel!.toJson());
      if (response.statusCode == 200) {
        setState(() {
          menuItems = response.children!;
        });
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(welcomeSnackBar);
      }
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
  void initState() {
    getConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(20.0))),
          toolbarHeight: 70.0,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
              color: light,
            ),
          ),
          centerTitle: true,
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 60.0,
                height: 60.0,
              ),
              Text(
                'Spashta Solutions',
                style: TextStyle(
                    color: light,
                    fontSize: 18.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  Icons.settings,
                  color: light,
                ),
              ),
            )
          ],
        ),
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
          child: Drawer(
            child: Container(
              color: light,
              child: ListView.builder(
                padding: EdgeInsets.only(right: 5.0, top: 10.0),
                shrinkWrap: true,
                itemCount: menuItems == null ? 0 : menuItems!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.only(
                        left: 0.0, top: 5.0, bottom: 5.0, right: 5.0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0))),
                    color: dark,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0)),
                      child: new ExpansionTile(
                        title: Text(
                          menuItems![index].name!,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              color: light,
                              fontWeight: FontWeight.normal),
                        ),
                        trailing:
                            Icon(Icons.arrow_drop_down_rounded, color: light),
                        children: buildSubMenu(menuItems![index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        endDrawerEnableOpenDragGesture: false,
        endDrawer: Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 160.0,
              child: Drawer(
                child: Container(
                  color: dark,
                  child: ListView(
                    padding: EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
                    children: [
                      Card(
                        margin: EdgeInsets.only(
                            left: 5.0, top: 5.0, bottom: 5.0, right: 5.0),
                        elevation: 2.5,
                        shadowColor: light,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: light,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => SwitchConnections()));
                          },
                          leading: Icon(
                            Icons.switch_account,
                            color: dark,
                          ),
                          title: Text(
                            'Switch Workspace',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                color: dark,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                            left: 5.0, top: 10.0, bottom: 5.0, right: 5.0),
                        elevation: 2.5,
                        shadowColor: light,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: light,
                        child: ListTile(
                          onTap: () {
                            logout();
                            setState(() {
                              isLoggedIn = false;
                            });
                            Navigator.of(context).pushAndRemoveUntil(
                                new MaterialPageRoute(
                                    builder: (context) => ConnectionPage()),
                                (route) => false);
                          },
                          leading: Icon(
                            Icons.logout,
                            color: dark,
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                color: dark,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Dashboard(),
      ),
    );
  }
}
