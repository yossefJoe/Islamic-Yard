import 'package:flutter/material.dart';
import 'package:islamic/Models/QuranReadingModel.dart';
import 'package:islamic/Presentation/Widgets/CustomAppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islamic/Constants/Constants.dart';

class ReadAyat extends StatelessWidget {
  final Surahs? surah;
  const ReadAyat({Key? key, this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Localizations.localeOf(context);
    String rightParenthesis = ')';
    String leftParenthesis = '(';

    String allAyahsWithNumbers = '';
    surah?.ayahs?.forEach((ayah) {
      allAyahsWithNumbers +=
          '${ayah.text?.trim()}${defaultLocale.languageCode == "ar" ? englishToArabicNumbers(ayah.numberInSurah.toString()) : leftParenthesis + ayah.numberInSurah.toString() + rightParenthesis} ';
    });

    return Scaffold(
      appBar:
          MyCustomAppbar(AppLocalizations.of(context)!.readquran, context, []),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 5)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                textDirection: defaultLocale.languageCode == "ar"
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                allAyahsWithNumbers,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: defaultLocale.languageCode == "ar"
                        ? "Uthmanic"
                        : "Lateef",
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
