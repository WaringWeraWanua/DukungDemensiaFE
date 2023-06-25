import 'package:flutter/material.dart';
import 'package:dukungan_demensia/pages/patient_schedule.dart';
import 'package:dukungan_demensia/pages/list_news.dart';

class BottomNavbarPatient extends StatefulWidget {
  const BottomNavbarPatient({super.key});

  @override
  State<BottomNavbarPatient> createState() =>
      _BottomNavbarPatientState();
}

class _BottomNavbarPatientState extends State<BottomNavbarPatient> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    PatientAlarmScreen(),
    ListNewsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Berita',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
