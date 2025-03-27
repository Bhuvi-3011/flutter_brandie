import 'package:brandie/Controllers/homeControllers.dart';
import 'package:brandie/Utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

class EditCaptionScreen extends StatefulWidget {
  final int reelIndex;

  const EditCaptionScreen({Key? key, required this.reelIndex})
    : super(key: key);

  @override
  _EditCaptionScreenState createState() => _EditCaptionScreenState();
}

class _EditCaptionScreenState extends State<EditCaptionScreen> {
  final homeController = Get.put(HomeController());
  late TextEditingController _captionController;
  RxBool isChanged = false.obs;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController(
      text: homeController.reelsData[widget.reelIndex].description,
    );
    _captionController.addListener(() {
      isChanged.value = _captionController.text.trim() != homeController.reelsData[widget.reelIndex].description;
    });
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void saveCaption() {
    homeController.updateReelCaption(
      widget.reelIndex,
      _captionController.text.trim(),
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close,size: px(32),),
          onPressed: () => Get.back(),
        ),
        title: Text("Edit Caption",style: TextStyle(fontSize: px(20),fontWeight: FontWeight.w700,color: Color(0xff2D2D2D)),),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: saveCaption,
            child: Container(
              width: 16.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Color(0xff7EC086),
                borderRadius: BorderRadius.circular(px(20)),
              ),
              child: Center(
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontFamily: "OriflameSans",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _captionController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          autofocus: true,
          decoration: InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}
