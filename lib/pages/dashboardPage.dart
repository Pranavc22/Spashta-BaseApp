import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/models/menu.dart';
import 'package:spashta_base_app/pages/connectionPage.dart';
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
    baseURL = prefs.getString('URL')!;
    module = prefs.getString('Module')!;
    division = prefs.getString('Division')!;
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
    await prefs.clear();
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
            IconButton(
                onPressed: () {
                  logout();
                  setState(() {
                    isLoggedIn = false;
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (context) => ConnectionPage()),
                      (route) => false);
                },
                icon: Icon(
                  Icons.logout,
                  color: light,
                  size: 20.0,
                ))
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
                        // collapsedBackgroundColor: light,
                        children: buildSubMenu(menuItems![index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        body: Dashboard(),
      ),
    );
  }
}
