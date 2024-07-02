import 'package:flutter/material.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:islamic/Constants/Provider_Methods.dart';
import 'package:provider/provider.dart';

class MyCustomAppbar extends AppBar {
  final String? text;
  final BuildContext? context;
  final List<Widget>? actions;
  MyCustomAppbar(this.text, this.context, this.actions)
      : super(
            actions: actions,
            backgroundColor: primary_color,
            leading: Consumer<IslamYardModel>(
              builder: (context, v, child) {
                return IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    v.start_over();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                );
              },
            ),
            centerTitle: true,
            title: Text(
              text!,
              style: TextStyle(color: Colors.white),
            ));
}
