import 'package:atomsbox/atomsbox.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return AppBottomNavBar(
      currentIndex: index,
      floating: true,
      items: [
        AppBottomNavBarItem(
          onTap: () {
            if (index == 0) {
              return;
            } else {
              context.goNamed('news-feed');
            }
          },
          icon: Icons.home,
          label: 'Home',
        ),
        AppBottomNavBarItem(
          onTap: () {
            if (index == 1) {
              return;
            } else {}
          },
          icon: Icons.book_rounded,
          label: 'Read Later',
        ),
        AppBottomNavBarItem(
          onTap: () {
            if (index == 2) {
              return;
            } else {
              // context.goNamed('login');
            }
          },
          icon: Icons.person,
          label: 'Profile',
        ),
      ],
    );
  }
}
