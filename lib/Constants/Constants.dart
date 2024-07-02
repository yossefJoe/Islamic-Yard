import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final Color primary_color = Color(0xff4E51BF);
final Color secondary_color = Color(0xffF8F6FF);
final Color third_color = Color(0xffEDF6E1);

class HeightSizedBox extends SizedBox {
  HeightSizedBox() : super(height: 40);
}

String getarabicmonths(int monthnumber) {
  List<String> arabicMonths = [
    'محرم',
    'صفر',
    'ربيع الأول',
    'ربيع الآخر',
    'جمادى الأولى',
    'جمادى الآخرة',
    'رجب',
    'شعبان',
    'رمضان',
    'شوال',
    'ذو القعدة',
    'ذو الحجة',
  ];

  return arabicMonths[monthnumber - 1]; // Month numbers in Hijri start from 1
}

String englishToArabicNumbers(String englishNumber) {
  String result = '';
  for (int i = 0; i < englishNumber.length; i++) {
    switch (englishNumber[i]) {
      case '0':
        result += '٠';
        break;
      case '1':
        result += '١';
        break;
      case '2':
        result += '٢';
        break;
      case '3':
        result += '٣';
        break;
      case '4':
        result += '٤';
        break;
      case '5':
        result += '٥';
        break;
      case '6':
        result += '٦';
        break;
      case '7':
        result += '٧';
        break;
      case '8':
        result += '٨';
        break;
      case '9':
        result += '٩';
        break;
      default:
        result += englishNumber[i];
    }
  }
  return result;
}

mixin class pray {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('hh:mm a');

  String Nextpray(BuildContext context, AsyncSnapshot snapshot) {
    Locale defaultLocale = Localizations.localeOf(context);

    if (now.isAfter(snapshot.data!.fajr) &&
        now.isBefore(snapshot.data!.dhuhr)) {
      return defaultLocale.languageCode == "ar" ? "الظهر" : "Dhuhr";
    } else if (now.isAfter(snapshot.data!.dhuhr) &&
        now.isBefore(snapshot.data!.asr)) {
      return defaultLocale.languageCode == "ar" ? "العصر" : "Asr";
    } else if (now.isAfter(snapshot.data!.asr) &&
        now.isBefore(snapshot.data!.maghrib)) {
      return defaultLocale.languageCode == "ar" ? "المغرب" : "Maghrib";
    } else if (now.isAfter(snapshot.data!.maghrib) &&
        now.isBefore(snapshot.data!.isha)) {
      return defaultLocale.languageCode == "ar" ? "العشاء" : "Isha";
    } else {
      return defaultLocale.languageCode == "ar" ? "الفجر" : "Fajir";
    }
  }

  String time(int time) {
    return englishToArabicNumbers("${time}");
  }

  String amorpm(String praytime) {
    return "${praytime[6] == "A" ? "صباحا" : "مساءا"}";
  }

  String zerobefore(int zero) {
    if (zero < 12) {
      return "${englishToArabicNumbers(0.toString())}";
    } else {
      return "";
    }
  }

  String PrayTime(BuildContext context, AsyncSnapshot snapshot) {
    Locale defaultLocale = Localizations.localeOf(context);

    if (now.isAfter(snapshot.data!.fajr) &&
        now.isBefore(snapshot.data!.dhuhr)) {
      return defaultLocale.languageCode == "ar"
          ? "${zerobefore(snapshot.data!.dhuhr.hour)}${time(snapshot.data!.dhuhr.hour)}:${zerobefore(snapshot.data!.dhuhr.minute)}${time(snapshot.data!.dhuhr.minute)} ${amorpm(formatter.format(snapshot.data!.dhuhr))}"
          : "${formatter.format(snapshot.data!.dhuhr)}";
    } else if (now.isAfter(snapshot.data!.dhuhr) &&
        now.isBefore(snapshot.data!.asr)) {
      return defaultLocale.languageCode == "ar"
          ? "${zerobefore(snapshot.data!.asr.hour)}${time(snapshot.data!.asr.hour)}:${zerobefore(snapshot.data!.asr.minute)}${time(snapshot.data!.asr.minute)} ${amorpm(formatter.format(snapshot.data!.asr))}"
          : "${formatter.format(snapshot.data!.asr)}";
    } else if (now.isAfter(snapshot.data!.asr) &&
        now.isBefore(snapshot.data!.maghrib)) {
      return defaultLocale.languageCode == "ar"
          ? "${zerobefore(snapshot.data!.maghrib.hour)}${time(snapshot.data!.maghrib.hour)}:${zerobefore(snapshot.data!.maghrib.minute)}${time(snapshot.data!.maghrib.minute)} ${amorpm(formatter.format(snapshot.data!.maghrib))}"
          : "${formatter.format(snapshot.data!.maghrib)}";
    } else if (now.isAfter(snapshot.data!.maghrib) &&
        now.isBefore(snapshot.data!.isha)) {
      return defaultLocale.languageCode == "ar"
          ? "${zerobefore(snapshot.data!.isha.hour)}${time(snapshot.data!.isha.hour)}:${zerobefore(snapshot.data!.isha.minute)}${time(snapshot.data!.isha.minute)} ${amorpm(formatter.format(snapshot.data!.isha))}"
          : "${formatter.format(snapshot.data!.isha)}";
    } else {
      return defaultLocale.languageCode == "ar"
          ? "${zerobefore(snapshot.data!.fajr.hour)}${time(snapshot.data!.fajr.hour)}:${zerobefore(snapshot.data!.fajr.minute)}${time(snapshot.data!.fajr.minute)} ${amorpm(formatter.format(snapshot.data!.fajr))}"
          : "${formatter.format(snapshot.data!.fajr)}";
    }
  }
}

class controltheme {
  Color? mytheme(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return Colors.grey[900];
    } else {
      return Colors.white;
    }
  }

  ThemeMode checktheme(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }
}
