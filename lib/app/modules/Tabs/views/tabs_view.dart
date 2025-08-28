import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            controller: controller.pageController,
            // 为了在滑动页面时底部导航发生变化
            onPageChanged: controller.setCurrentIndex,
            children: controller.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              fixedColor: Colors.red,
              currentIndex: controller.CurrentIndex.value,
              onTap: (value) {
                controller.setCurrentIndex(value);
                controller.pageController.jumpToPage(controller.CurrentIndex.value);
              },
              // 超过4个时要配置这个参数，不然不会显示
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: '分类'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.room_service), label: '服务'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: '购物车'),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: '用户'),
              ]),
        ));
  }
}
