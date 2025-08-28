import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Category/views/category_view.dart';
import '../../home/views/home_view.dart';
import '../../give/views/give_view.dart';
import '../../cart/views/cart_view.dart';
import '../../user/views/user_view.dart';

class TabsController extends GetxController {
  RxInt CurrentIndex = 0.obs;
  PageController pageController = Get.arguments != null
      ? PageController(initialPage: 4)
      : PageController(initialPage: 0);
  final List<Widget> pages = [
    HomeView(),
    CategoryView(),
    GiveView(),
    CartView(),
    UserView()
  ];

  @override
  void onInit() {
    if (Get.arguments != null) {
      CurrentIndex.value = Get.arguments['initialPage'];
      update();
    }
    super.onInit();
  }

  void setCurrentIndex(value) {
    CurrentIndex.value = value;
    update();
  }
}
