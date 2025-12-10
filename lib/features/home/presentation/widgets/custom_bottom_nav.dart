import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CustomBottomNav({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation:
          index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = navigationShell.currentIndex;

    return BottomNavigationBar(
      elevation: 5,
      selectedFontSize: 15,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),
      currentIndex: navigationShell.currentIndex,
      onTap: _onTap,
      selectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          label: 'Chat',
          icon: Icon(
            currentIndex == 0
                ? Icons.chat
                : Icons.chat_outlined,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Users',
          icon: Icon(
            currentIndex == 1
                ? Icons.people_alt
                : Icons.people_alt_outlined,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(
            currentIndex == 2
                ? Icons.person
                : Icons.person_outline,
          ),
        ),
      ],
    );
  }
}
