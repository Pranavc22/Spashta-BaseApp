import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: double.infinity, minWidth: double.infinity),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/watermark.png'), fit: BoxFit.fill),
      ),
    );
  }
}
