import 'package:flutter/material.dart';
import 'package:dukungan_demensia/pages/login_page.dart';
import 'package:alarm/alarm.dart';
import 'dart:async';
import 'package:dukungan_demensia/pages/caretaker_schedule.dart';

Future<void> main() async {
  await Alarm.init(showDebugLogs: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CaretakerPage(title: "Alarm"),
    );
  }
}