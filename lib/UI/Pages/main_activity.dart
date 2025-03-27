import 'package:brandie/Utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:brandie/UI/Pages/home_page/homePage.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int _currentIndex = 2; // Default on Home

  late final Homepage homepage;

  @override
  void initState() {
    super.initState();
    homepage = Homepage();
  }

  final List<Widget> _pages = [
    const Share(),
    const Search(),
    Homepage(),
    const chatScreen(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          IndexedStack(
            // Keeps state of pages
            index: _currentIndex,
            children: _pages,
          ),

          /// Floating Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: SizedBox(
              height: 6.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem("assets/icons/rocket.png", 0),
                  _buildNavItem("assets/icons/search.png", 1),
                  _buildNavItem("assets/icons/home.png", 2),
                  _buildNavItem("assets/icons/messages.png", 3),
                  _buildNavItem("assets/icons/profile.png", 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Navigation item builder
  Widget _buildNavItem(String iconPath, int index) {
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Opacity(
        opacity: _currentIndex == index ? 0.5 : 1,
        child: Image.asset(
          iconPath,
          height: px(28),
          width: px(28),
          color: _currentIndex != 2 ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("Search Screen")),
    );
  }
}

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("Share Screen")),
    );
  }
}

class chatScreen extends StatelessWidget {
  const chatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("Chat Screen")),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("Profile Screen")),
    );
  }
}
