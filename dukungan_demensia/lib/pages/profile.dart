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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40,),
            CircleAvatar(
              radius: 70,
              backgroundColor: ColorLayout.brBlue100,
            ),
            SizedBox(height: 40,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorLayout.blue2,
                boxShadow: [
                  BoxShadow(
                    color: ColorLayout.black3.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ]
              ),
              child: ListTile(
                title: Text('Nama'),
                subtitle: Text('John Doe'),
                leading: Icon(CupertinoIcons.person),
                tileColor: ColorLayout.blue2,
              ),
            ),
            SizedBox(height: 40,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorLayout.blue2,
                boxShadow: [
                  BoxShadow(
                    color: ColorLayout.black3.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ]
              ),
              child: ListTile(
                title: Text('Username'),
                subtitle: Text('johndoe'),
                leading: Icon(CupertinoIcons.person),
                tileColor: ColorLayout.blue2,
              ),
            ),
            SizedBox(height: 40,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorLayout.blue2,
                boxShadow: [
                  BoxShadow(
                    color: ColorLayout.black3.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ]
              ),
              child: ListTile(
                title: Text('Email'),
                subtitle: Text('johndoe@gmail.com'),
                leading: Icon(CupertinoIcons.person),
                tileColor: ColorLayout.blue2,
              ),
            ),
            SizedBox(height: 40,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorLayout.blue2,
                boxShadow: [
                  BoxShadow(
                    color: ColorLayout.black3.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ]
              ),
              child: ListTile(
                title: Text('Phone'),
                subtitle: Text('+62 812 3456 7890'),
                leading: Icon(CupertinoIcons.person),
                tileColor: ColorLayout.blue2,
              ),
            )
          ]
        ),
      ),
    );
  }
}