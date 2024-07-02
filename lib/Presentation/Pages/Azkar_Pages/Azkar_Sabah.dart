import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamic/Models/Dua_Model.dart';
import 'package:islamic/Presentation/Widgets/CustomAppBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class AzkarSabah extends StatefulWidget {
  const AzkarSabah({super.key});

  @override
  State<AzkarSabah> createState() => _AzkarSabahState();
}

class _AzkarSabahState extends State<AzkarSabah> {
  List<Dua> azkarsabah = [];

  Future<List<Dua>> fetshazkar(int? start, int end) async {
    const delayBetweenRequests =
        Duration(milliseconds: 100); // Adjust as needed
    try {
      for (int i = start ?? 1; i <= end; i++) {
        String apiUrl =
            "https://dua-dhikr.vercel.app/categories/morning-dhikr/$i";

        final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Accept-Language': 'id', // Adjust the language code as needed
          },
        );

        if (response.statusCode == 200) {
          final decodedData = json.decode(response.body)['data'];
          var zikr = Dua.fromJson(decodedData);

          azkarsabah.add(zikr);
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

      return azkarsabah;
    } catch (e) {
      // Catch any exceptions that occur during the fetching process
      print('Error fetching data: $e');
      // Return an empty list in case of error
      return [];
    }
  }

  @override
  void initState() {
    fetshazkar(1, 11);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Localizations.localeOf(context);

    return Scaffold(
        appBar: MyCustomAppbar(
            AppLocalizations.of(context)!.azkarsabah, context, []),
        body: azkarsabah.isNotEmpty && azkarsabah.length == 11
            ? ListView.builder(
                itemCount: azkarsabah.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.blue[800],
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Arial"),
                              "${defaultLocale.languageCode == "ar" ? azkarsabah[index].arabic : azkarsabah[index].latin}")),
                    ),
                  );
                })
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    AppLocalizations.of(context)!.loading + "...",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              )));
  }
}
