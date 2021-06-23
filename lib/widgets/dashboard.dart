import 'package:flutter/material.dart';
import 'package:spashta_base_app/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/watermark.png'),
            fit: BoxFit.cover),
      ),
      // constraints: BoxConstraints.expand(),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Container(
      //       margin: EdgeInsets.only(
      //           left: 10.0, top: 20.0, bottom: 10.0, right: 10.0),
      //       decoration: BoxDecoration(
      //         boxShadow: [
      //           BoxShadow(color: dark, blurRadius: 2.0, offset: Offset.zero)
      //         ],
      //         color: dark,
      //         borderRadius: BorderRadius.circular(20.0),
      //       ),
      //       child: Padding(
      //         padding:
      //             const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      //         child: Text(
      //           'Welcome back! \n' + user.toUpperCase(),
      //           textAlign: TextAlign.center,
      //           style: TextStyle(
      //               color: light,
      //               // height: 1.0,
      //               fontSize: 18.0,
      //               fontWeight: FontWeight.w300,
      //               fontFamily: 'Poppins'),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
