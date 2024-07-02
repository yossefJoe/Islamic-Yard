import 'package:flutter/material.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islamic/Presentation/Pages/Azkar_Pages/Azkar_Masaa.dart';
import 'package:islamic/Presentation/Pages/Azkar_Pages/Azkar_Sabah.dart';

class AzkarWidget extends StatelessWidget {
  const AzkarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Positioned(
        top: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return AzkarSabah();
                                            },
                                          ));
                                        },
                                        icon: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 40,
                                          child: ClipOval(
                                            child: Image.asset(
                                              "Assets/Images/day.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .azkarsabah,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) {
                                                return AzkarMasaa();
                                              },
                                            ));
                                          },
                                          icon: CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Colors.transparent,
                                            child: ClipOval(
                                              child: Image.asset(
                                                "Assets/Images/night.jpg",
                                              ),
                                            ),
                                          )),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .azkarmasaa,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    child: Container(
                        color: theme.brightness == Brightness.light
                            ? secondary_color
                            : Colors.grey,
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Center(
                          child: ListTile(
                            title: Text(
                              AppLocalizations.of(context)!.azkar,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white),
                            ),
                            subtitle: Text(
                              AppLocalizations.of(context)!.azkarsabah +
                                  "\n" +
                                  AppLocalizations.of(context)!.azkarmasaa,
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
                                  child: Image.asset(
                                    "Assets/Images/azkar.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                )),
                          ),
                        )),
                  ),
                ))));
  }
}
