import 'package:flutter/material.dart';
import 'package:spashta_base_app/styling/textStyles.dart';

class NotSupported extends StatelessWidget {
  final String? message;

  NotSupported({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: double.infinity, minWidth: double.infinity),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/watermark.png'), fit: BoxFit.fill),
      ),
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
              message == null
                  ? "We are sorry. Something unexpected has occurred. Please try again later."
                  : message!,
              style: messageTextStyle)),
    );
  }
}
