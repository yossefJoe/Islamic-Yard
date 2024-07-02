import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islamic/Constants/Provider_Methods.dart';
import 'package:provider/provider.dart';

class TimeDateWidget extends StatelessWidget {
  const TimeDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Localizations.localeOf(context);

    DateTime nowdate = DateTime.now();
    String dayofweek =
        DateFormat('EEEE', defaultLocale.languageCode == "ar" ? "ar" : "en")
            .format(nowdate);
    String month =
        DateFormat('MMMM', defaultLocale.languageCode == "ar" ? "ar" : "en")
            .format(nowdate);
    initializeDateFormatting('ar'); // Initialize Arabic date symbols

    HijriCalendar today = HijriCalendar.now();
    String arabicHijriYear = englishToArabicNumbers(today.hYear.toString());

    String arabichijri =
        '${englishToArabicNumbers(today.hDay.toString())} ${getarabicmonths(today.hMonth)} ${arabicHijriYear}';
    final ThemeData theme = Theme.of(context);

    return Positioned(
        top: MediaQuery.of(context).size.height * 0.15,
        left: 0,
        right: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.elliptical(20, 40)),
          child: Container(
              color: theme.brightness == Brightness.light
                  ? secondary_color
                  : Colors.grey,
              height: 200,
              width: 400,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${dayofweek},${defaultLocale.languageCode == "ar" ? englishToArabicNumbers(nowdate.day.toString()) : nowdate.day} ${month}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${defaultLocale.languageCode == "ar" ? arabichijri : today.toFormat(
                              "dd MM yyyy " "AH",
                            )}",
                          style: TextStyle(
                              fontSize: 20,
                              color: theme.brightness == Brightness.light
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                        HeightSizedBox(),
                        Consumer<IslamYardModel>(
                          builder: (context, v, child) {
                            return FutureBuilder(
                              future: v.getPrayerTimes(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.next +
                                            " : "
                                                "${pray().Nextpray(context, snapshot)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${pray().PrayTime(context, snapshot)}",
                                        // snapshot.data!.fajr.hour
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.amber,
                                  ));
                                }
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 100,
                    child: Image.asset(
                      "Assets/Images/mos.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              )),
        ));
  }
}
