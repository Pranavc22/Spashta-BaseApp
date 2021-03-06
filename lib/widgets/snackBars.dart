import 'package:flutter/material.dart';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/styling/textStyles.dart';

final loginSuccessSnackBar = SnackBar(
  backgroundColor: dark,
  elevation: 10.0,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0))),
  content: Row(children: [
    Text('Login Successful.', style: dataTitleTextStyle),
    SizedBox(width: 20.0),
    Icon(
      Icons.check_circle,
      size: 18.0,
      color: light,
    )
  ]),
);

final unauthorizedSnackBar = SnackBar(
  backgroundColor: dark,
  elevation: 10.0,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0))),
  content: Text('Unauthorized. Please check your username and password.',
      style: dataTitleTextStyle),
);

final urlNotFoundSnackBar = SnackBar(
  backgroundColor: dark,
  elevation: 10.0,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0))),
  content: Text('Invalid URL. Please try again.', style: dataTitleTextStyle),
);

final welcomeSnackBar = SnackBar(
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
  backgroundColor: dark,
  elevation: 2.0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  content: Text('Welcome back!\n' + user.toUpperCase(),
      textAlign: TextAlign.center, style: dataTitleTextStyle),
);

final sessionExpiredSnackBar = SnackBar(
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
  backgroundColor: dark,
  elevation: 2.0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  content: Text('Session expired. Please login again.',
      textAlign: TextAlign.center, style: dataTitleTextStyle),
);
