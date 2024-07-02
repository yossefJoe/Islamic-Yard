import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:islamic/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IslamYardModel with ChangeNotifier {
  double progress_value = 0;

  void count_tasbeeh() {
    if (progress_value < 33) {
      progress_value +=
          1; // Increment value by 0.1 and clamp it between 0 and 1
      notifyListeners();
    }
  }

  void start_over() {
    progress_value = 0;
    notifyListeners();
  }

  Locale _locale = Locale('ar', '');

  Locale get locale => _locale;

  void changeLanguage(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  Future<PrayerTimes> getPrayerTimes() async {
    final coordinates =
        Coordinates(30.033333, 31.233334); // Coordinates for New York City

    final params = CalculationMethod.egyptian.getParameters();

    final prayerTimes = PrayerTimes(
      coordinates,
      DateComponents.from(DateTime.now()),
      params,
    );

    return prayerTimes;
  }

  IslamYardModel(bool isDark) {
    if (isDark) {
      _themeData = ThemeData.dark();
    } else {
      _themeData = ThemeData.light();
    }
  }
  ThemeData _themeData = ThemeData.light();
  ThemeData get themdata => _themeData;
  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_themeData == ThemeData.light()) {
      _themeData = ThemeData.dark();
      prefs.setBool('is_dark', true);
    } else {
      _themeData = ThemeData.light();
      prefs.setBool('is_dark', false);
    }
    notifyListeners();
  }
}
