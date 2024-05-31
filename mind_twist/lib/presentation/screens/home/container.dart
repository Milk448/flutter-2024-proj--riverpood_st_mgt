import 'package:flutter/material.dart';
import 'package:mind_twist/presentation/screens/home/home_screen.dart';
import 'package:mind_twist/presentation/screens/teaser/teaser_screen.dart';
import 'package:mind_twist/presentation/screens/profile/profile.dart';
import 'package:go_router/go_router.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const TeaserScreen(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_rounded),
            label: 'Teasers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 255, 200),
        backgroundColor: const Color.fromARGB(255, 120, 113, 200),
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
