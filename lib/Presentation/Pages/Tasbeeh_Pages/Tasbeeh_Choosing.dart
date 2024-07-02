import 'package:flutter/material.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:islamic/Constants/Provider_Methods.dart';
import 'package:islamic/Presentation/Pages/Tasbeeh_Pages/Tasbeeh_Counter.dart';
import 'package:islamic/Presentation/Widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasbeehPage extends StatelessWidget {
  TasbeehPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final List<String> tasbeeh = [
      AppLocalizations.of(context)!.alhamdullah,
      AppLocalizations.of(context)!.astaghfirallah,
      AppLocalizations.of(context)!.lahawlwlakwaelabillah,
      AppLocalizations.of(context)!.laillahelaallah,
      AppLocalizations.of(context)!.bismillah,
      AppLocalizations.of(context)!.allahakbar,
    ];

    return Consumer(
      builder: (context, v, child) {
        return Scaffold(
          appBar: MyCustomAppbar(
              AppLocalizations.of(context)!.tasbeeh, context, []),
          body: ListView(
            children: [
              ListView.builder(
                itemCount: tasbeeh.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ChosenTasbeeh(
                                  tasbeeh: tasbeeh[i],
                                );
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                child: Container(
                                    height: 100,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Center(
                                      child: ListTile(
                                        title: Text(
                                          tasbeeh[i],
                                          style: TextStyle(
                                              color: theme.brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          AppLocalizations.of(context)!.praise,
                                          style: TextStyle(
                                              color: theme.brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                        trailing: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                              color: third_color,
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                              )),
                                        ),
                                        tileColor:
                                            theme.brightness == Brightness.light
                                                ? secondary_color
                                                : Colors.grey,
                                        leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              color: third_color,
                                              child: Image.asset(
                                                  "Assets/Images/sebha.png"),
                                            )),
                                      ),
                                    )),
                              ),
                            ),
                          ))
                    ],
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
