import 'package:flutter/material.dart';
import 'package:islamic/Api/Api.dart';
import 'package:islamic/Models/QuranReadingModel.dart';
import 'package:islamic/Presentation/Pages/Reading_Quran_Pages/Read_Aya_Page.dart';

class QuranReadingPage extends StatefulWidget {
  const QuranReadingPage({super.key});

  @override
  State<QuranReadingPage> createState() => _QuranReadingPageState();
}

class _QuranReadingPageState extends State<QuranReadingPage> {
  Future<List<Surahs>>? readarabic;
  Future<List<Surahs>>? readenglish;

  @override
  void initState() {
    readarabic = Api().arabicquran();
    readenglish = Api().englishquran();
    super.initState();
  }

  String surahtype(AsyncSnapshot snapshot, i) {
    if (snapshot.data![i].revelationType == "Medinan") {
      return "مدنية";
    } else {
      return "مكية";
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Localizations.localeOf(context);
    return Scaffold(
      body: FutureBuilder(
        future: defaultLocale.languageCode == "ar" ? readarabic : readenglish,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Image.asset("Assets/Images/offline.gif"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ReadAyat(surah: snapshot.data![i]);
                        },
                      ));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          tileColor: Colors.purple,
                          trailing: Text(
                            defaultLocale.languageCode == "ar"
                                ? surahtype(snapshot, i)
                                : snapshot.data![i].revelationType!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            "${defaultLocale.languageCode == "ar" ? snapshot.data![i].name : snapshot.data![i].englishName}",
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset(
                "Assets/Images/Animation - 1714477138322.gif",
              ),
            );
          } else {
            return Center(
              child: Text("No data available"),
            );
          }
        },
      ),
    );
  }
}
