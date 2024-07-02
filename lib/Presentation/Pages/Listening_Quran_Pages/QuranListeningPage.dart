import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:islamic/Api/Api.dart';
import 'package:islamic/Presentation/Widgets/CustomAppBar.dart';

class QuranListeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppbar("Listen to Quran", context, []),
    );
  }
}
