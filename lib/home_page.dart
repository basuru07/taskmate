import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:taskmate/bottom_nav_bar/messaging.dart';
import 'package:taskmate/bottom_nav_bar/proposals.dart';
import 'package:taskmate/bottom_nav_bar/jobs.dart';
import 'package:taskmate/bottom_nav_bar/account.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  final List _items = [
    const Messaging(),
    const Proposals(),
    const Jobs(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        gap: 5.0,
        selectedIndex: _selectedIndex,
        onTabChange: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        tabs: const [
          GButton(
            icon: Icons.mail_outline,
            text: 'Messages',
          ),
          GButton(
            icon: Icons.work_history,
            text: 'Job Status',
          ),
          GButton(
            icon: Icons.work,
            text: 'Jobs',
          ),
          GButton(
            icon: Icons.person,
            text: 'Account',
          ),
        ],
      ),
      body: _items[_selectedIndex],
    );
  }
}
