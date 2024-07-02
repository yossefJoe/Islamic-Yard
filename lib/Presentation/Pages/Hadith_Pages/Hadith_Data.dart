import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamic/Models/HadithModel.dart';
import 'package:http/http.dart ' as http;
import 'package:islamic/Models/Hadith_Type.dart';
import 'package:islamic/Presentation/Widgets/CustomAppBar.dart';
import 'package:translator/translator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Hadithtext extends StatefulWidget {
  final Hadithtype? bookname;
  Hadithtext({super.key, this.bookname});

  @override
  State<Hadithtext> createState() => _HadithtextState();
}

class _HadithtextState extends State<Hadithtext> {
  List items = [1, 2, 3, 4];
  Future<String> translateText(String arabictext) async {
    final translator = GoogleTranslator();
    final Translation translation =
        await translator.translate(arabictext, to: 'en');
    return translation.text;
  }

  List<HadithData> allHadiths = [];
  @override
  void initState() {
    gethadith(widget.bookname!.id, 1, 30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Localizations.localeOf(context);

    return Scaffold(
        appBar: MyCustomAppbar(
            AppLocalizations.of(context)!.readhadith, context, []),
        body: allHadiths.isNotEmpty && allHadiths.length == 30
            ? ListView.builder(
                itemCount: allHadiths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.blueGrey,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: defaultLocale.languageCode == "ar"
                            ? Text(
                                allHadiths[index].contents!.arab.toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Uthmanic",
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )
                            : FutureBuilder(
                                future: translateText(allHadiths[index]
                                    .contents!
                                    .arab
                                    .toString()),
                                builder: (context, translate) {
                                  if (translate.hasData) {
                                    return Text(
                                      translate.data.toString(),
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Arial",
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                },
                              ),
                      ),
                    ),
                  );
                })
            : Center(child: Image.asset("Assets/Images/muhammed.gif")));
  }

  Future<List<HadithData>> gethadith(String? id, int? start, int end) async {
    for (int i = start ?? 1; i <= end; i++) {
      String apiurl = "https://api.hadith.gading.dev/books/${id}/${i}";

      final response = await http.get(Uri.parse(apiurl));
      if (response.statusCode == 200) {
        final decodedate = json.decode(response.body)['data'];
        var res = HadithData.fromJson(decodedate);
        allHadiths.add(res);
        setState(() {});
      } else {
        throw Exception("Something Happened");
      }
    }

    return allHadiths;
  }
}
