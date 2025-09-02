//using PageView.jumpToPage() or  indexedstack
import 'package:flutter/material.dart';
import 'package:khetihar/BottomNavigation/BottomNavigation.dart';
import 'package:khetihar/Community/Community.dart';
import 'package:khetihar/HomePages/HomePage.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final PageController _controller = PageController();
  int _current = 0;

  // Put all your tab pages here
  final List<Widget> _pages = const [
    HomePage(),
    Community(),
    // ChatScreen(),
    // VideosScreen(),
    // ProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() => _current = index);
    _controller.jumpToPage(index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Pages
          PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
          ),

          // Floating Bottom Navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomPillNav(
              currentIndex: _current,
              onTap: _onTap,
              items: const [
                BottomPillItem(icon: Icons.home_rounded),
                BottomPillItem(icon: Icons.groups_rounded),
                BottomPillItem(icon: Icons.chat_bubble_outline_rounded),
                BottomPillItem(icon: Icons.ondemand_video_rounded),
                BottomPillItem(icon: Icons.person_outline_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
