import 'package:dukungan_demensia/pages/login_page.dart';
import 'package:dukungan_demensia/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'dart:async';
import 'package:dukungan_demensia/pages/caretaker_schedule.dart';
import 'package:dukungan_demensia/pages/patient_schedule.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:camera/camera.dart';

var camera;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Alarm.init(showDebugLogs: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  camera = cameras.first;
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