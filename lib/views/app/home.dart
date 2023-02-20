import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:we_link_app/res/colors.dart';
import 'package:we_link_app/views/app/home/home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
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
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Iconsax.home),
            ),
            BottomNavigationBarItem(
              label: "Stats",
              icon: Icon(Iconsax.chart),
            ),
            BottomNavigationBarItem(
              label: "Edit",
              icon: Icon(Iconsax.edit),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(Iconsax.setting),
            ),
          ]),
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
