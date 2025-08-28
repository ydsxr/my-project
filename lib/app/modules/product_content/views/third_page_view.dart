import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import '../controllers/product_content_controller.dart';

class ThirdPageView extends GetView {
  @override
  final ProductContentController controller = Get.find();
  ThirdPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.globalKey3,
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(3000),
      alignment: Alignment.center,
      color: Colors.yellow,
      child: Text('推荐'),
    );
  }
}
