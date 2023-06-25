import 'package:flutter/material.dart';
import 'package:dukungan_demensia/pages/caretaker_schedule.dart';
import 'package:dukungan_demensia/pages/list_news.dart';

class BottomNavbarCaretaker extends StatefulWidget {
  const BottomNavbarCaretaker({super.key});

  @override
  State<BottomNavbarCaretaker> createState() =>
      _BottomNavbarCaretakerState();
}

class _BottomNavbarCaretakerState extends State<BottomNavbarCaretaker> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    CaretakerAlarmScreen(),
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
