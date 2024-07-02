import 'package:flutter/material.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:islamic/Constants/Provider_Methods.dart';
import 'package:islamic/Presentation/Widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagesPage extends StatelessWidget {
  LanguagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppbar(
          AppLocalizations.of(context)!.selectlanguage, context, []),
      body: Consumer<IslamYardModel>(
        builder: (context, v, child) {
          return Column(
            children: [
              RadioTileItem(
                image: "usa.png",
                groupValue: v.locale,
                onChanged: (locale) {
                  v.changeLanguage(locale!);
                },
                title: AppLocalizations.of(context)!.english,
                value: Locale("en", ''),
              ),
              RadioTileItem(
                image: "egypt.png",
                groupValue: v.locale,
                onChanged: (locale) {
                  v.changeLanguage(locale!);
                },
                title: AppLocalizations.of(context)!.arabic,
                value: Locale("ar"),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RadioTileItem extends StatelessWidget {
  const RadioTileItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    required this.image,
  });
  final Locale value;
  final Locale groupValue;
  final void Function(Locale?)? onChanged;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RadioListTile<Locale>(
        controlAffinity: ListTileControlAffinity.trailing,
        secondary: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: theme.brightness == Brightness.light
                ? Colors.white
                : Colors.transparent,
            height: 50,
            width: 50,
            child: SizedBox(
              height: 30,
              width: 30,
              child: ClipOval(
                child: Image.asset(
                  "Assets/Images/$image",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        contentPadding: EdgeInsets.all(20),
        hoverColor: Colors.transparent,
        activeColor:
            theme.brightness == Brightness.light ? Colors.black : Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        tileColor: theme.brightness == Brightness.light
            ? secondary_color
            : Colors.grey,
        title: Text(
          title,
          style: TextStyle(
              color: theme.brightness == Brightness.light
                  ? Colors.black
                  : Colors.white),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
