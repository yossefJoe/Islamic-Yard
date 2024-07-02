import 'package:flutter/material.dart';
import 'package:islamic/Constants/Provider_Methods.dart';
import 'package:islamic/Presentation/Pages/WlcomePage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool("is_dark") ?? false;

  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return IslamYardModel(isDark);
    }, child: Consumer<IslamYardModel>(
      builder: (context, value, child) {
        return MaterialApp(
            locale: value.locale,
            supportedLocales: [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            debugShowCheckedModeBanner: false,
            title: 'IslamicYard',
            theme: value.themdata,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            home: WelcomePage());
      },
    ));
  }
}
