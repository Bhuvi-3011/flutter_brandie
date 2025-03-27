import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadingAnimationDialog extends StatefulWidget {
  final int selectedIndex; // New: Selected social media index

  const LoadingAnimationDialog({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<LoadingAnimationDialog> createState() => _LoadingAnimationDialogState();
}

class _LoadingAnimationDialogState extends State<LoadingAnimationDialog> {
  int currentImageIndex = 0;

  final List<String> loadingImages = [
    "assets/images/generating.png",
    "assets/images/copying.png",
    "assets/images/saving.png",
    "assets/images/preparing.png",
  ];

  Timer? _timer;

  String instaId = "the_capricious_spirit";

  final List<Map<String, String>> socialLinks = [
    {"app": "instagram://user?username=the_capricious_spirit", "web": "https://www.instagram.com/the_capricious_spirit"},
    {"app": "instagram://user?username=the_capricious_spirit", "web": "https://www.instagram.com/the_capricious_spirit"},
    {"app": "fb://profile/Bhuvneshwari_Durairaj", "web": "https://www.facebook.com/Bhuvneshwari_Durairaj"},
    {"app": "fb://profile/Bhuvneshwari_Durairaj", "web": "https://www.facebook.com/Bhuvneshwari_Durairaj"},
    {"app": "fb-messenger://user-thread/Bhuvneshwari_Durairaj", "web": "https://www.messenger.com/t/Bhuvneshwari_Durairaj"},
    {"app": "fb-messenger://user-thread/Bhuvneshwari_Durairaj", "web": "https://www.messenger.com/t/Bhuvneshwari_Durairaj"},
    {"app": "whatsapp://send?phone=your_phone", "web": "https://wa.me/your_phone"},
    {"app": "whatsapp://send?phone=your_phone", "web": "https://wa.me/your_phone"},
    {"app": "tg://resolve?domain=your_telegram", "web": "https://t.me/your_telegram"},
    {"app": "mailto:your_email@example.com", "web": "mailto:your_email@example.com"},
  ];

  @override
  void initState() {
    super.initState();
    _startImageLoop();
  }

  void _startImageLoop() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        _timer?.cancel();
        return;
      }

      if (currentImageIndex < loadingImages.length - 1) {
        setState(() {
          currentImageIndex++;
        });
      } else {
        _timer?.cancel();
        Future.delayed(const Duration(seconds: 1), _redirectToApp); // Redirect after animation
      }
    });
  }

  Future<void> _redirectToApp() async {
  final String? appUri = socialLinks[widget.selectedIndex]["app"];
  final String? webUri = socialLinks[widget.selectedIndex]["web"];

  if (appUri != null && appUri.isNotEmpty) {
    if (await canLaunchUrl(Uri.parse(appUri))) {
      await launchUrl(Uri.parse(appUri), mode: LaunchMode.externalApplication);
      Navigator.pop(context); // Close the dialog after launching the app
      return;
    }
  }

  // If app is not available, try web link
  if (webUri != null && webUri.isNotEmpty) {
    if (await canLaunchUrl(Uri.parse(webUri))) {
      await launchUrl(Uri.parse(webUri), mode: LaunchMode.externalApplication);
    }
  }

  Navigator.pop(context); // Close the dialog in case of failure or fallback to web
}


  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          );
        },
        child: Image.asset(
          loadingImages[currentImageIndex],
          key: ValueKey<int>(currentImageIndex),
          width: 300,
          height: 300,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
