import 'dart:convert';
import 'package:islamic/Models/Hadith_Type.dart';
import 'package:islamic/Models/QuranTafseerModel.dart';
import 'package:islamic/Models/QuranReadingModel.dart';
import 'package:http/http.dart' as http;
import 'package:islamic/Models/Tafseer_Type_Mode.dart';

class Api {
  Future<List<Surahs>> arabicquran() async {
    String arabicquran = "https://api.alquran.cloud/v1/quran/ar.asad";

    final response = await http.get(Uri.parse(arabicquran));
    if (response.statusCode == 200) {
      final decodedate = json.decode(response.body)['data']['surahs'] as List;
      return decodedate.map((surah) => Surahs.fromJson(surah)).toList();
    } else {
      return throw Exception("Something Happened");
    }
  }

  Future<List<Surahs>> englishquran() async {
    String englishquran = "https://api.alquran.cloud/v1/quran/en.asad";

    final response = await http.get(Uri.parse(englishquran));
    if (response.statusCode == 200) {
      final decodedate = json.decode(response.body)['data']['surahs'] as List;
      return decodedate.map((surah) => Surahs.fromJson(surah)).toList();
    } else {
      return throw Exception("Something Happened");
    }
  }

  Future<List<Tafseer>> getTafseer(int? surah_id, int? ayah_number,
      int? ayah_ending, int? tafseer_id) async {
    String apiUrl =
        "http://api.quran-tafseer.com/tafseer/${tafseer_id}/${surah_id}/${ayah_number}/${ayah_ending}";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decodedData = utf8.decode(response.bodyBytes);
      final decodeutf8 = json.decode(decodedData) as List;
      return decodeutf8.map((tafseer) => Tafseer.fromJson(tafseer)).toList();
    } else {
      return throw Exception("Something Happened");
    }
  }

  Future<List<Tafseertype>> tafseertype(String? type) async {
    String apiurl = "http://api.quran-tafseer.com/tafseer/";

    final response = await http.get(Uri.parse(apiurl));
    if (response.statusCode == 200) {
      final decodedData = utf8.decode(response.bodyBytes);
      final decodeutf8 = json.decode(decodedData) as List;
      return type == "ar"
          ? decodeutf8
              .map((tafseertype) => Tafseertype.fromJson(tafseertype))
              .where((element) => element.language == "ar")
              .toList()
          : decodeutf8
              .map((tafseertype) => Tafseertype.fromJson(tafseertype))
              .where((element) => element.language == "en")
              .toList();
    } else {
      return throw Exception("Something Happened");
    }
  }

  Future<List<Hadithtype>> choosehadith() async {
    String apiurl = "https://api.hadith.gading.dev/books/";

    final response = await http.get(Uri.parse(apiurl));
    if (response.statusCode == 200) {
      final decodedate = json.decode(response.body)['data'] as List;
      return decodedate
          .map((hadithtype) => Hadithtype.fromJson(hadithtype))
          .where((element) =>
              element.name != "HR. Ahmad" &&
              element.name != "HR. Tirmidzi" &&
              element.name != "HR. Malik" &&
              element.name !=
                  "HR. Ibnu Majah") // Exclude Hadith type named "Ahmad"
          .toList();
    } else {
      throw Exception("Something Happened");
    }
  }
}
