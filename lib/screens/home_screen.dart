import 'package:flutter/material.dart';

import 'package:otp_flutter/screens/add_screen.dart';
import 'package:otp_flutter/screens/list_screen.dart';
import 'package:otp_flutter/screens/qr_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    const AddScreen(),
    const ListScreen(),
    const QRScreen(),
  ];

  final List<AppBar> _appBars = <AppBar>[
    AppBar(
      title: const Text('Secret Code'),
      backgroundColor: Colors.indigoAccent,
    ),
    AppBar(
      title: const Text('OTP List'),
      backgroundColor: Colors.indigoAccent,
    ),
    AppBar(
      title: const Text('QR Code'),
      backgroundColor: Colors.indigoAccent,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.elementAt(_selectedIndex),
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'ADD'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_2), label: 'QR'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigoAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
