import 'package:flutter/material.dart';
import 'package:islamic/Api/Api.dart';
import 'package:islamic/Models/QuranReadingModel.dart';
import 'package:islamic/Models/QuranTafseerModel.dart';
import 'package:islamic/Presentation/Widgets/CustomAppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TafseerPage extends StatelessWidget {
  final Surahs? title;
  final int? id;

  const TafseerPage({Key? key, this.title, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppbar(
          AppLocalizations.of(context)!.tafseerquran, context, []),
      body: FutureBuilder(
        future: Api().getTafseer(title?.number, 1, title?.ayahs?.length, id!),
        builder: (context, AsyncSnapshot<List<Tafseer>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.amber),
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
                  child: Card(
                    child: ListTile(
                        title: Text(
                          "${title?.ayahs?[index].text}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Amiri",
                          ),
                        ),
                        subtitle: Text(
                          "${snapshot.data?[index].text}",
                          style: TextStyle(
                            fontFamily: "Amiri",
                            fontSize: 20,
                          ),
                        )),
                  ),
                );
              },
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
