import 'package:brandie/Controllers/homeControllers.dart';
import 'package:brandie/UI/Pages/home_page/smartPost/editCaption.dart';
import 'package:brandie/UI/Pages/home_page/smartPost/loadingAnimation.dart';
import 'package:brandie/Utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class SmartPost extends StatefulWidget {
  final PageController pageController;

  const SmartPost({super.key, required this.pageController});

  @override
  State<SmartPost> createState() => _SmartPostState();
}

class _SmartPostState extends State<SmartPost> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.reelsData.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return PageView.builder(
        controller: widget.pageController,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: homeController.reelsData.length,
        itemBuilder: (context, index) {
          final reel = homeController.reelsData[index];
          return SizedBox.expand(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(reel.image, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: const AssetImage(
                          'assets/images/profile_pic.png',
                        ),
                        radius: px(22),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/tag.png",
                            width: 40.w,
                            height: 4.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 1.w),
                            child: Text(
                              "High-converting in Oriflame Community",
                              style: TextStyle(
                                fontFamily: "OriflameSans",
                                color: Colors.white,
                                fontSize: px(12),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 2.h,
                  right: 4.w,
                  child: ReelIndicator(
                    currentIndex: index,
                    totalCount: homeController.reelsData.length,
                  ),
                ),
                Positioned(
                  bottom: 130,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSongContainer(
                        Icons.music_note,
                        reel.lead, // Lead name
                        reel.song, // Song name
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          pushWithoutNavBar(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      EditCaptionScreen(reelIndex: index),
                            ),
                          );
                        },
                        child: _buildInfoContainer(null, reel.description),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 70,
                  left: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    height: 50,
                    child: Row(
                      children: [
                        Text(
                          "Quick share to:",
                          style: TextStyle(
                            fontFamily: "OriflameSans",
                            color: Colors.white,
                            fontSize: px(12),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeController.socialIcons.length,
                            itemBuilder:
                                (context, iconIndex) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: GestureDetector(
                                    onTap:
                                        () => showDialog(
                                          context: context,
                                          builder:
                                              (context) =>
                                                  LoadingAnimationDialog(
                                                    selectedIndex: iconIndex,
                                                  ),
                                        ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        homeController.socialIcons[iconIndex],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildInfoContainer(IconData? icon, String text) => Container(
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
    decoration: BoxDecoration(
      color: const Color(0xff313131).withOpacity(0.39),
      borderRadius: BorderRadius.circular(px(8)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) Icon(icon, color: Colors.white, size: 16),
        if (icon != null) const SizedBox(width: 5),
        Expanded(
          child: Text.rich(
            _formatText(text),
            style: TextStyle(
              fontFamily: "OriflameSans",
              color: Colors.white70.withOpacity(0.8),
              fontSize: px(12),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );

  TextSpan _formatText(String text) {
    List<TextSpan> spans = [];
    RegExp exp = RegExp(
      r"(#[\w]+)|(\bUK-AMANDA3012\b)|(\bwww.oriflame.com[^\s]+)",
    );

    text.splitMapJoin(
      exp,
      onMatch: (Match match) {
        if (match[0]!.startsWith("#")) {
          spans.add(
            TextSpan(
              text: "${match[0]} ",
              style: const TextStyle(
                fontFamily: "OriflameSans",
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          );
        } else if (match[0]!.startsWith("UK-")) {
          spans.add(
            TextSpan(
              text: match[0],
              style: const TextStyle(
                fontFamily: "OriflameSans",
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (match[0]!.startsWith("www.")) {
          spans.add(
            TextSpan(
              text: match[0],
              style: const TextStyle(
                fontFamily: "OriflameSans",
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          );
        }
        return "";
      },
      onNonMatch: (String nonMatch) {
        spans.add(TextSpan(text: nonMatch));
        return "";
      },
    );

    return TextSpan(children: spans);
  }

  Widget _buildSongContainer(IconData? icon, String text, String highlight) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
        decoration: BoxDecoration(
          color: const Color(0xff313131).withOpacity(0.39),
          borderRadius: BorderRadius.circular(px(8)),
        ),
        child: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.white, size: 16),
            if (icon != null) const SizedBox(width: 5),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Recommended: ",
                      style: TextStyle(
                        fontFamily: "OriflameSans",
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: highlight, // Highlighted part (song name)
                      style: const TextStyle(
                        fontFamily: "OriflameSans",
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: " by ${text}", // Remaining part (lead name)
                      style: const TextStyle(
                        fontFamily: "OriflameSans",
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class ReelIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalCount;

  const ReelIndicator({
    super.key,
    required this.currentIndex,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
    decoration: BoxDecoration(
      color: Color(0xff313131).withOpacity(0.39),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      "${currentIndex + 1} of $totalCount",
      style: TextStyle(
        //fontFamily: "OriflameSans",
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: px(10),
      ),
    ),
  );
}
