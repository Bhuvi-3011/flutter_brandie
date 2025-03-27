import 'package:brandie/Controllers/homeControllers.dart';
import 'package:brandie/UI/Pages/main_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter binding is ready
  Get.put(HomeController()); // Put all required controllers here
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (p0, p1, p2) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainActivity(),
        );
      },
    );
  }
}
