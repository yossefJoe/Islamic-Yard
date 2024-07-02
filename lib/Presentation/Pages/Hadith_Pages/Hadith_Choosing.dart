import 'package:flutter/material.dart';
import 'package:islamic/Api/Api.dart';
import 'package:islamic/Presentation/Pages/Hadith_Pages/Hadith_Data.dart';
import 'package:translator/translator.dart';

class HadithChoosing extends StatelessWidget {
  const HadithChoosing({Key? key});

  @override
  Widget build(BuildContext context) {
    Future<String> translateText(String englishText) async {
      final translator = GoogleTranslator();
      final Translation translation =
          await translator.translate(englishText, to: 'ar');
      return translation.text;
    }

    Locale defaultLocale = Localizations.localeOf(context);
    String changename(String name) {
      if (name == "أبو ديفيد") {
        return "أبو داود";
      } else {
        return name;
      }
    }

    bool checknull(String? name) {
      return name != null && name.length > 4;
    }

    return Scaffold(
      body: FutureBuilder(
        future: Api().choosehadith(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final hadithName = "${snapshot.data![index].name}";
                return checknull(hadithName)
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return Hadithtext(
                                bookname: snapshot.data![index],
                              );
                            },
                          ));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20, bottom: 20),
                              child: ListTile(
                                tileColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: defaultLocale.languageCode == "en"
                                    ? Text(
                                        hadithName.substring(4),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      )
                                    : FutureBuilder(
                                        future: translateText(
                                          hadithName.substring(4),
                                        ),
                                        builder: (context, translate) {
                                          if (translate.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            );
                                          } else if (translate.hasError) {
                                            return Center(
                                              child: Text("${translate.error}"),
                                            );
                                          } else {
                                            return Text(
                                              changename(
                                                  translate.data.toString()),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink();
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset("Assets/Images/muhammed.png"),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
