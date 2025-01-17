// navbar.dart
import 'package:flutter/material.dart';
import 'package:rabbi_roots_delivery/screens/earning_screen/earning_screen.dart';
import 'package:rabbi_roots_delivery/screens/homescreen/homescreen.dart';
import 'package:rabbi_roots_delivery/screens/profile/profile_screen.dart';

class Navbar extends StatefulWidget {
  Navbar({
    Key? key,
  }) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<Widget> _screens = [
    const HomeScreen(),
    MyEarningsScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;
  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onDestinationSelected,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Earning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
    // bottomNavigationBar: NavigationBar(
    //     backgroundColor: Colors.white,
    //     height: 70,
    //     selectedIndex: _currentIndex,
    //     onDestinationSelected: _onDestinationSelected,
    //     destinations: [
    //       NavigationDestination(
    //           selectedIcon: Icon(Icons.home,
    //               color: Theme.of(context).colorScheme.inversePrimary),
    //           icon: Icon(
    //             Icons.home,
    //           ),
    //           label: "Home"),
    //       NavigationDestination(
    //           selectedIcon: Icon(Icons.laptop_mac_rounded,
    //               color: Theme.of(context).colorScheme.inversePrimary),
    //           icon: Icon(Icons.laptop_mac_rounded),
    //           label: "Marketing"),
    //       NavigationDestination(
    //           selectedIcon: Icon(Icons.book,
    //               color: Theme.of(context).colorScheme.inversePrimary),
    //           icon: Icon(Icons.book),
    //           label: "Academy"),
    //       NavigationDestination(
    //           selectedIcon: Icon(Icons.support_agent,
    //               color: Theme.of(context).colorScheme.inversePrimary),
    //           icon: Icon(Icons.support_agent),
    //           label: "Support")
    //     ]));
  }
}
