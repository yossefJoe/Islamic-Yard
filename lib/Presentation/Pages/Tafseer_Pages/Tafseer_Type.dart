import 'package:flutter/material.dart';
import 'package:islamic/Api/Api.dart';
import 'package:islamic/Models/QuranReadingModel.dart';
import 'package:islamic/Presentation/Pages/Tafseer_Pages/Tafseer_text.dart';

class TafseerType extends StatelessWidget {
  final Surahs? title;
  const TafseerType({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Localizations.localeOf(context);

    return Scaffold(
      body: FutureBuilder(
        future: defaultLocale.languageCode == "ar"
            ? Api().tafseertype("ar")
            : Api().tafseertype("en"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return TafseerPage(
                            title: title,
                            id: snapshot.data![index].id,
                          );
                        },
                      ));
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            tileColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            title: Text(
                              "${snapshot.data?[index].name}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Amiri",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "${snapshot.data?[index].author}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Uthmanic"),
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Image.asset("Assets/Images/offline.gif"),
            );
          } else {
            return Center(
              child: Image.asset("Assets/Images/Animation - 1715057587787.gif"),
            );
          }
        },
      ),
    );
  }
}
