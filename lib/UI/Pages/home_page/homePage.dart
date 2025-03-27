import 'package:brandie/Controllers/homeControllers.dart';
import 'package:brandie/UI/Pages/home_page/smartPost/smartPost.dart';
import 'package:brandie/UI/Widgets/header.dart';
import 'package:brandie/Utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _pageController = PageController();
  final homeController = Get.put(HomeController(), permanent: true);
  int selectedTabIndex = 0; // Hardcoded tab selection

  @override
  void initState() {
    super.initState();
    homeController.getData(); // Ensure data is loaded if needed
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 14.h, child: buildHeader()),
          Container(
            height: 5.h,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                4,
                (index) => GestureDetector(
                  onTap: () => setState(() => selectedTabIndex = index),
                  child: Text(
                    [
                      "Smart Post",
                      "Library",
                      "Communities",
                      "Share & Win",
                    ][index],
                    style: TextStyle(
                      fontSize: px(14),
                      fontWeight: FontWeight.w700,
                      color:
                          selectedTabIndex == index
                              ? const Color(0xff73BF98)
                              : const Color(0xff595959),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: selectedTabIndex,
              children: [
                Obx(() {
                  return homeController.isDataLoaded.value
                      ? SmartPost(pageController: _pageController)
                      : Center(child: CircularProgressIndicator());
                }),
                Center(child: Text('Library screen coming soon...')),
                Center(child: Text('Communities screen coming soon...')),
                Center(child: Text('Share & Win screen coming soon...')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
