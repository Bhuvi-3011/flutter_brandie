import 'package:brandie/Utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget buildHeader() {
  return SizedBox(
    height: 14.h,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: 60.w,
              height: 5.h,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            top: 7.5.h,
            right: 0,
            child: CircleAvatar(
              radius: 23,
              backgroundColor: Colors.green.shade200,
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
