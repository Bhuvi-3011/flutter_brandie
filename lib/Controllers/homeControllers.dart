import 'package:brandie/Models/reelModel.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt currentTabIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final RxInt currentLoadingIndex = 0.obs;

  var isDataLoaded = false.obs;

void getData() async {
  await Future.delayed(Duration(seconds: 2)); // Simulate API call
  isDataLoaded.value = true;
}

  RxList<String> loadingImages = [
    "assets/images/generating.png",
    "assets/images/copying.png",
    "assets/images/saving.png",
    "assets/images/preparing.png",
  ].obs;

  final List<String> socialIcons = [
    "assets/icons/insta1.png",
    "assets/icons/insta2.png",
    "assets/icons/fb1.png",
    "assets/icons/fb2.png",
    "assets/icons/messenger.png",
    "assets/icons/tiktok.png",
    "assets/icons/wa1.png",
    "assets/icons/wa2.png",
    "assets/icons/telegram.png",
    "assets/icons/mail.png",
    "assets/icons/heart.png",
  ];

  RxList<ReelModel> reelsData = <ReelModel>[
    ReelModel(
      image: 'assets/images/img1.png',
      song: "Bad Habits",
      lead: "Ed Sheeran",
      description: "\uD83D\uDC84Elevate your beauty with the Giordani Gold - Eternal Glow Lipstick SPF 25! This luxurious creamy lipstick doesn't just promise rich pigments but brings you the benefits of hyaluronic acid and collagen-boosting peptides too. Pamper your lips with care while enjoying a long-lasting, luminous matte colour.\uD83D\uDC8B✨ #Oriflame #GiordaniGold #LipCareGoals\nUse my referral code: UK-AMANDA3012\nUse my referral link: www.oriflame.com/giordani/amada3012",
    ),
    ReelModel(
      image: 'assets/images/img2.png',
      song: "Unstoppable",
      lead: "Sia",
      description: "✨ Experience the elegance of Eclat Amour—a fragrance that captures the essence of romance and sophistication. Let every spritz wrap you in timeless charm and effortless allure. 💕 #EclatAmour #TimelessElegance\nUse my referral code: UK-AMANDA3012\nUse my referral link: www.oriflame.com/giordani/amada3012",
    ),
    ReelModel(
      image: 'assets/images/img3.png',
      song: "Vogue",
      lead: "Madonna",
      description: "Unlock the power of bold, beautiful lashes! With WonderLash Mascara, get ultimate length, volume, and definition for a stunning, eye-catching look. One swipe is all it takes! 💖 #WonderLash #LashesForDays\nUse my referral code: UK-AMANDA3012\nUse my referral link: www.oriflame.com/giordani/amada3012",
    ),
  ].obs;

  void addReel(ReelModel newReel) {
    reelsData.add(newReel);
  }

  void changeTabIndex(int index) {
    if (currentTabIndex.value != index) {
      currentTabIndex.value = index;
    }
  }

  Future<void> startLoadingAnimation() async {
    if (loadingImages.isEmpty) return;

    isLoading.value = true;
    for (int i = 0; i < loadingImages.length; i++) {
      currentLoadingIndex.value = i;
      await Future.delayed(Duration(seconds: 1));
    }
    isLoading.value = false;
  }

  void updateReelCaption(int index, String newCaption) {
    if (index >= 0 && index < reelsData.length) {
      reelsData[index] = ReelModel(
        image: reelsData[index].image,
        song: reelsData[index].song,
        lead: reelsData[index].lead,
        description: newCaption,
      );
    }
  }
}
