import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

import '../Search/searchmain/search.dart';
import '../ai_chat/presentation/pages/ai_chat_screen.dart';
import '../home/home.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    SearchMainScreen(),
    const Center(
      child: Text(
        "Bookmarks",
        style: TextStyle(fontSize: 24),
      ),
    ),
    const AiChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectedIndex],

      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color(0xff001F3F),
        buttonBackgroundColor: const Color(0xffFFA500),
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home, color: Colors.white),
            label: "Home",
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.search, color: Colors.white),
            label: "Search",
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.bookmark, color: Colors.white),
            label: "Bookmarks",
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.support_agent, color: Colors.white),
            label: "AI Support",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}