import 'package:dukungan_demensia/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dukungan_demensia/pages/patient_schedule.dart';
import 'package:dukungan_demensia/pages/list_news.dart';
import 'package:dukungan_demensia/components/globals.dart' as globals;

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

  void _launchPhoneCall() async {
    final client = PairApi();
    final pair = await client.getPairPhoneNumber();
    print(pair);
    globals.pairPhoneNumber = pair.user!.phoneNumber!;
    String url = 'tel:${globals.pairPhoneNumber.toString()}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchPhoneCall();
        },
        label: const Text('Call Caregiver'),
        icon: const Icon(Icons.phone),
        backgroundColor: Colors.lightBlue,
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
