import 'package:flutter/material.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:islamic/Presentation/Pages/Home_Page/Widgets/Azkar_Widget.dart';
import 'package:islamic/Presentation/Pages/Home_Page/Widgets/Pages_Raw.dart';
import 'package:islamic/Presentation/Pages/Home_Page/Widgets/Tasbeeh_Widget.dart';
import 'package:islamic/Presentation/Pages/Home_Page/Widgets/Time_Date_Widget.dart';
import 'package:islamic/Presentation/Widgets/CustomDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.75,
              child: AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(40))),
                title: Text(
                  AppLocalizations.of(context)!.islamicyard,
                  style: TextStyle(color: Colors.white),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: theme.brightness == Brightness.light
                    ? primary_color
                    : Colors.blue[900],
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
              )),
          TimeDateWidget(),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.42,
              child: Center(child: CustomRow())),
          TasbeehWidget(),
          AzkarWidget()
        ],
      ),
    );
  }
}
