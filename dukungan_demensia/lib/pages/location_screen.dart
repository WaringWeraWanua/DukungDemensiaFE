import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:dukungan_demensia/pages/edit_alarm.dart';
import 'package:dukungan_demensia/pages/ring.dart';
import 'package:dukungan_demensia/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:dukungan_demensia/models/schedule_models.dart';
import 'package:dukungan_demensia/services/schedule_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/layout/colors_layout.dart';
import 'package:dukungan_demensia/widgets/layout/text_layout.dart';
import 'package:dukungan_demensia/components/globals.dart' as globals;

import 'package:dukungan_demensia/models/proof_image_models.dart';
import 'package:dukungan_demensia/services/proof_image_api.dart';

class LoationScreen extends StatelessWidget {
  const LoationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text('Lokasi Pasien', style: TextLayout.display24.copyWith(color: ColorLayout.blue4)),
            const SizedBox(height: 40),
            Container(
              width:300,
              child: Image.network("https://www.digitaltrends.com/wp-content/uploads/2020/06/penn1.jpg?fit=750%2C1334&p=1"),
            ),
          ],
        )
      )
    );
  }
}