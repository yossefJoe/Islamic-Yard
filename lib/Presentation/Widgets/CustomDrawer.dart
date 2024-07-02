import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamic/Constants/Provider_Methods.dart';
import 'package:islamic/Presentation/Pages/ChangeLanguage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islamic/main.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    void shareApp(BuildContext context) {
      final ThemeData theme = Theme.of(context);

      final RenderBox box = context.findRenderObject() as RenderBox;
      Share.share(
        'Check out this amazing Flutter app!', //app link
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    }

    return Consumer<IslamYardModel>(
      builder: (context, value, child) {
        return Drawer(
            child: Stack(
          children: [
            Column(
              children: [
                Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      "Assets/Images/dmosque.jpg",
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    )),
                Column(
                  children: [
                    DrawerItem(
                      iconcolor: Colors.blueAccent,
                      ontap: () {
                        print("pressed");
                        shareApp(context);
                      },
                      text: AppLocalizations.of(context)?.share,
                      icon: Icons.share,
                    ),
                    DrawerItem(
                      iconcolor: Colors.blue,
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return LanguagesPage();
                          },
                        ));
                      },
                      text: AppLocalizations.of(context)?.changelanguage,
                      icon: Icons.g_translate_sharp,
                    ),
                    DrawerItem(
                      iconcolor: Colors.orange,
                      ontap: () {
                        value.toggleTheme();
                      },
                      text: AppLocalizations.of(context)?.changeTheme,
                      icon: Icons.light_mode,
                    ),
                    DrawerItem(
                      iconcolor: Colors.red,
                      ontap: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                      text: AppLocalizations.of(context)?.exit,
                      icon: Icons.exit_to_app_outlined,
                    ),
                  ],
                )
              ],
            ),
            Positioned(
                top: 30,
                left: 20,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.transparent,
                      height: 30,
                      width: 30,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          )),
                    )))
          ],
        ));
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  final VoidCallback? ontap;
  final String? text;
  final IconData? icon;
  final Color? iconcolor;
  const DrawerItem(
      {super.key, this.ontap, this.text, this.icon, this.iconcolor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Icon(
            icon,
            color: iconcolor,
          ),
          title: Text(
            text!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}
