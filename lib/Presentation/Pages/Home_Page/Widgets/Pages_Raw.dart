import 'package:flutter/material.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:islamic/Presentation/Pages/Dua_Pages/Dua_Text.dart';
import 'package:islamic/Presentation/Pages/Hadith_Pages/Hadith_Choosing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islamic/Presentation/Pages/Reading_Quran_Pages/Quran_Reading_Page.dart';
import 'package:islamic/Presentation/Pages/Tafseer_Pages/Surah_Choosing.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          RowElement(
            image: "Assets/Images/muhammed.png",
            color: theme.brightness == Brightness.light
                ? primary_color
                : Colors.blue[900],
            text: AppLocalizations.of(context)!.hadith,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return HadithChoosing();
                },
              ));
            },
          ),
          RowElement(
            image: "Assets/Images/dua.jpg",
            color: theme.brightness == Brightness.light
                ? secondary_color
                : Colors.grey,
            text: AppLocalizations.of(context)!.dua,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return DuaText();
                },
              ));
            },
          ),
          RowElement(
              image: "Assets/Images/hadis.png",
              color: theme.brightness == Brightness.light
                  ? secondary_color
                  : Colors.grey,
              text: AppLocalizations.of(context)!.quran,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return QuranReadingPage();
                  },
                ));
              }),
          RowElement(
            image: "Assets/Images/tafseer.png",
            color: theme.brightness == Brightness.light
                ? secondary_color
                : Colors.grey,
            text: AppLocalizations.of(context)!.tafseer,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return SurahChoosing();
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}

class RowElement extends StatelessWidget {
  final String? image;
  final String? text;
  final Color? color;
  final VoidCallback? onTap;
  const RowElement({super.key, this.image, this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(image!),
                  ),
                  Text(
                    text!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.brightness == Brightness.light
                            ? Colors.black
                            : Colors.white),
                  )
                ],
              ),
              color: color,
              height: 120,
              width: 60,
            )),
      ),
    );
  }
}
