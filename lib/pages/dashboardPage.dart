import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/models/dashboard.dart';
import 'package:spashta_base_app/styling/textStyles.dart';
import 'package:spashta_base_app/models/menu.dart';
import 'package:spashta_base_app/models/query.dart';
import 'package:spashta_base_app/models/table.dart';
import 'package:spashta_base_app/models/instances.dart';
import 'package:spashta_base_app/models/replicas.dart';
import 'package:spashta_base_app/pages/connectionPage.dart';
import 'package:spashta_base_app/pages/switchConnections.dart';
import 'package:spashta_base_app/services/menuService.dart';
import 'package:spashta_base_app/services/instancesService.dart';
import 'package:spashta_base_app/services/replicasService.dart';
import 'package:spashta_base_app/services/queryService.dart';
import 'package:spashta_base_app/widgets/dashboard.dart';
import 'package:spashta_base_app/widgets/tableDashboard.dart';
import 'package:spashta_base_app/widgets/notSupported.dart';
import 'package:spashta_base_app/widgets/snackBars.dart';
import 'package:spashta_base_app/widgets/progressHUD.dart';
import 'package:spashta_base_app/widgets/multiDashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isAPICall = false;
  List<MenuChild>? menuItems;
  MenuRequestModel? menuRequestModel;
  InstancesRequestModel? instancesRequestModel;
  ReplicasRequestModel? replicasRequestModel;
  QueryRequestModel? queryRequestModel;
  Widget? bodyWidget;

  List<Widget> buildSubMenu(MenuChild menuChild) {
    List<Widget> items = [];
    for (MenuChildChild subMenuItems in menuChild.children!) {
      items.add(
        new ListTile(
          onTap: () {
            setState(() {
              isAPICall = true;
            });
            runQuery(subMenuItems.name!, subMenuItems.actionId!);
            Navigator.of(context).pop();
          },
          title: Text(subMenuItems.name!, style: dataTextStyle),
        ),
      );
    }
    return items;
  }

  void runQuery(String query, String actionId) {
    queryRequestModel = new QueryRequestModel(
        sessionid: sessionID,
        json: "{\"query\":\"" +
            query +
            "\",\"actionId\":\"" +
            actionId +
            "\",\"user\":\"" +
            user +
            "\",\"instance\":\"" +
            instance! +
            "\",\"replica\":\"" +
            replica! +
            "\"}");
    QueryService queryService = QueryService();
    queryService.getQuery(queryRequestModel!).then((response) {
      setState(() {
        isAPICall = false;
      });
      if (response.statusCode == 200) {
        setState(() {
          if (response.type == "TABLE") {
            TableResponseModel tableResponse = response;
            bodyWidget = TableDashboard(response: tableResponse);
          } else if (response.type == "MULTI") {
            DashboardResponseModel dashboardResponse = response;
            bodyWidget = MultiDashboard(response: dashboardResponse);
          } else if (response.type == "NOT_SUPPORTED") {
            QueryResponseModel queryResponse = response;
            bodyWidget = NotSupported(message: queryResponse.message);
          }
        });
      } else {
        QueryResponseModel queryResponse = response;
        setState(() {
          bodyWidget = NotSupported(message: queryResponse.message);
        });
      }
    });
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
    instancesRequestModel = new InstancesRequestModel(
        sessionId: sessionID,
        json: "{\"query\":\"List Instance\",\"user\":\"" +
            user +
            "\",\"actionId\":\"instances\",\"module\":\"" +
            module! +
            "\",\"division\":\"" +
            division +
            "\",\"instance\":\"\",\"replica\":\"\"}");
    InstancesService instancesService = InstancesService();
    instancesService.getInstances(instancesRequestModel!).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          instance = response.values!.last;
        });
        replicasRequestModel = new ReplicasRequestModel(
            sessionId: sessionID,
            json:
                "{\"query\":\"List Replica\",\"actionId\":\"replica\",\"instance\":\"" +
                    instance! +
                    "\",\"replica\":\"\",\"user\":\"" +
                    user +
                    "\"}");
        ReplicasService replicasService = ReplicasService();
        replicasService
            .getReplicas(replicasRequestModel!)
            .then((replicaResponse) {
          if (replicaResponse.statusCode == 200) {
            setState(() {
              replica = replicaResponse.values!.last;
            });
          }
        });
      }
    });
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
      if (response.statusCode == 200) {
        setState(() {
          menuItems = response.children!;
        });
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(welcomeSnackBar);
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(sessionExpiredSnackBar);
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
    setState(() {
      bodyWidget = Dashboard();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: dashboardUI(context),
        inAsyncCall: isAPICall,
        opacity: 0.5,
        color: light);
  }

  Widget dashboardUI(BuildContext context) {
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
              Text('Spashta Solutions', style: appBarTextStyle),
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
                        title: Text(menuItems![index].name!,
                            style: dataTitleTextStyle),
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
                          title: Text('Switch Workspace',
                              style: userSettingsTextStyle),
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
                          title: Text('Logout', style: userSettingsTextStyle),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: bodyWidget,
      ),
    );
  }
}
