import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:we_link_app/res/colors.dart';
import 'package:we_link_app/views/app/edit/edit_screen.dart';
import 'package:we_link_app/views/app/home/home_screen.dart';
import 'package:we_link_app/views/app/links/link_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    LinkListScreen(),
    Text(
      'Index 1: Business',
    ),
    EditLinkProfile(),
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
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          selectedLabelStyle: const TextStyle(fontSize: 11),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Iconsax.home),
            ),
            BottomNavigationBarItem(
              label: "Links",
              icon: Icon(Iconsax.link_1),
            ),
            BottomNavigationBarItem(
              label: "Stats",
              icon: Icon(Iconsax.chart),
            ),
            BottomNavigationBarItem(
              label: "Appearance",
              icon: Icon(Iconsax.edit),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(Iconsax.setting),
            ),
          ]),
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
