import 'package:flutter/material.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islamic/Presentation/Pages/Tasbeeh_Pages/Tasbeeh_Choosing.dart';

class TasbeehWidget extends StatelessWidget {
  const TasbeehWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Positioned(
        top: MediaQuery.of(context).size.height * 0.65,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return TasbeehPage();
                    }));
                  },
                  child: Card(
                    child: Container(
                        color: theme.brightness == Brightness.light
                            ? secondary_color
                            : Colors.grey,
                        height: 75,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Center(
                          child: ListTile(
                            title: Text(
                              AppLocalizations.of(context)!.tasbeeh,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white),
                            ),
                            subtitle: Text(
                              AppLocalizations.of(context)!.praise,
                              style: TextStyle(
                                  color: theme.brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white),
                            ),
                            trailing: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  color: third_color,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                  )),
                            ),
                            tileColor: secondary_color,
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: third_color,
                                  child: Image.asset("Assets/Images/sebha.png"),
                                )),
                          ),
                        )),
                  ),
                ))));
  }
}
