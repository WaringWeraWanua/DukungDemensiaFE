import 'package:dukungan_demensia/pages/login_page.dart';
import 'package:dukungan_demensia/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'dart:async';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
      },
      home: const LoginPage(),
    );
  }
}