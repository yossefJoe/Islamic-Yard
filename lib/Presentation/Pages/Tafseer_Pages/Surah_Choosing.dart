import 'package:flutter/material.dart';
import 'package:islamic/Api/Api.dart';
import 'package:islamic/Models/QuranReadingModel.dart';
import 'package:islamic/Presentation/Pages/Tafseer_Pages/Tafseer_Type.dart';
import 'package:islamic/Presentation/Pages/Tafseer_Pages/Tafseer_text.dart';

class SurahChoosing extends StatefulWidget {
  const SurahChoosing({Key? key}) : super(key: key);

  @override
  State<SurahChoosing> createState() => _SurahChoosingState();
}

class _SurahChoosingState extends State<SurahChoosing> {
  late Future<List<Surahs>> readArabic;
  late Future<List<Surahs>> readEnglish;

  @override
  void initState() {
    readArabic = Api().arabicquran();
    readEnglish = Api().englishquran();
    super.initState();
  }

  String surahType(AsyncSnapshot<List<Surahs>> snapshot, int index) {
    if (snapshot.data![index].revelationType == "Medinan") {
      return "مدنية";
    } else {
      return "مكية";
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Localizations.localeOf(context);
    Future<List<Surahs>>? selectedSurahs =
        defaultLocale.languageCode == "ar" ? readArabic : readEnglish;

    return Scaffold(
      body: FutureBuilder(
        future: selectedSurahs,
        builder: (context, AsyncSnapshot<List<Surahs>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset("Assets/Images/Animation - 1715049931843.gif"),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Image.asset("Assets/Images/offline.gif"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return TafseerType(
                            title: snapshot.data?[index],
                          );
                        },
                      ));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          tileColor: Colors.indigo,
                          trailing: Text(
                            defaultLocale.languageCode == "ar"
                                ? surahType(snapshot, index)
                                : snapshot.data![index].revelationType!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            "${defaultLocale.languageCode == "ar" ? snapshot.data![index].name : snapshot.data![index].englishName}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Image.asset(
                "Assets/Images/Animation - 1714477138322.gif",
              ),
            );
          }
        },
      ),
    );
  }
}
