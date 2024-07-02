import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:islamic/Models/Dua_Model.dart';
import 'package:islamic/Presentation/Widgets/CustomAppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DuaText extends StatefulWidget {
  const DuaText({super.key});

  @override
  State<DuaText> createState() => _DuaTextState();
}

class _DuaTextState extends State<DuaText> {
  List<Dua> allDuas = [];

  Future<List<Dua>> fetchDuas(int? start, int end) async {
    const delayBetweenRequests =
        Duration(milliseconds: 100); // Adjust as needed
    try {
      for (int i = start ?? 1; i <= end; i++) {
        String apiUrl = "https://dua-dhikr.vercel.app/categories/daily-dua/$i";
        final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Accept-Language': 'id', // Adjust the language code as needed
          },
        );

        if (response.statusCode == 200) {
          final decodedData = json.decode(response.body)['data'];
          var dua = Dua.fromJson(decodedData);

          allDuas.add(dua);
        } else {
          // If the response status code is not 200, throw an error
          throw Exception(
              "Failed to load data for Dua $i. Status code: ${response.statusCode}");
        }

        // Add a delay between requests to avoid hitting the rate limit
        await Future.delayed(delayBetweenRequests);
      }

      // Update the state after fetching all Duas
      setState(() {});

      return allDuas;
    } catch (e) {
      // Catch any exceptions that occur during the fetching process
      print('Error fetching data: $e');
      // Return an empty list in case of error
      return [];
    }
  }

  @override
  void initState() {
    fetchDuas(1, 38);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Localizations.localeOf(context);

    return Scaffold(
        appBar: MyCustomAppbar(AppLocalizations.of(context)!.duas, context, []),
        body: allDuas.isNotEmpty && allDuas.length == 38
            ? ListView.builder(
                itemCount: allDuas.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.deepPurple,
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Arial"),
                              "${defaultLocale.languageCode == "ar" ? allDuas[index].arabic : allDuas[index].latin}")),
                    ),
                  );
                })
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "Assets/Images/Animation - 1715271564182.gif",
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      AppLocalizations.of(context)!.loading + "...",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ));
  }
}
