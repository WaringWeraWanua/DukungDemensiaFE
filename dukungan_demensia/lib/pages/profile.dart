// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dukungan_demensia/widgets/layout/text_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/layout/colors_layout.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: ColorLayout.brBlue75,
                      ),
                      SizedBox(height: 60,),
                      Container(
                        child: ListTile(
                          title: Text('John Doe'),
                          subtitle: Text('Nama'),
                          titleTextStyle: TextLayout.display28.copyWith(color: ColorLayout.black5),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: ListTile(
                          title: Text('johndoe'),
                          subtitle: Text('Username'),
                          titleTextStyle: TextLayout.display28.copyWith(color: ColorLayout.black5),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: ListTile(
                          title: Text('johndoe@gmail.com'),
                          subtitle: Text('Email'),
                          titleTextStyle: TextLayout.display28.copyWith(color: ColorLayout.black5),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: ListTile(
                          title: Text('+62 812 3456 7890'),
                          subtitle: Text('Phone'),
                          titleTextStyle: TextLayout.display28.copyWith(color: ColorLayout.black5),
                        ),
                      )
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}