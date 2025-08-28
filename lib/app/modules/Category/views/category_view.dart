import 'package:flutter/material.dart';
import '../../../services/httpsClients.dart';
import '../../../services/screenAdapter.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              Get.toNamed('/search');
            },
            child: Container(
              width: ScreenAdapter.width(840),
              height: ScreenAdapter.height(96),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        ScreenAdapter.width(34), 0, ScreenAdapter.width(10), 0),
                    child: const Icon(Icons.search),
                  ),
                  Text("手机",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScreenAdapter.fontSize(32)))
                ],
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.message_outlined, color: Colors.black45))
          ],
          elevation: 0,
        ),
        body: Row(
          children: [
            _leftcate(),
            _rightcate(),
          ],
        ));
  }

  Widget _leftcate() {
    return SizedBox(
        width: ScreenAdapter.width(280),
        // sizedbox里面嵌套listview，宽度设为自适应
        height: double.infinity,
        child: Obx(
          () => ListView.builder(
              itemCount: controller.leftCategoryList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  height: ScreenAdapter.width(180),
                  child: InkWell(
                      onTap: () {
                        controller.changeSelectIndex(
                            index, controller.leftCategoryList[index].id);
                      },
                      child: Obx(
                        () => Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: ScreenAdapter.width(10),
                                height: ScreenAdapter.height(46),
                                color: controller.selectIndex.value == index
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                            Center(
                              child: Text(
                                '${controller.leftCategoryList[index].title}',
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(26),
                                    fontWeight:
                                        controller.selectIndex.value == index
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              }),
        ));
  }

  Widget _rightcate() {
    return Expanded(
        child: SizedBox(
            height: double.infinity,
            child: Obx(
              () => GridView.builder(
                itemCount: controller.rightCategoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: ScreenAdapter.width(40),
                    mainAxisSpacing: ScreenAdapter.height(20),
                    childAspectRatio: 240 / 340),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // 会生成一个返回按钮
                      Get.toNamed('/productlist', arguments: {
                        'cid': controller.rightCategoryList[index].id
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Image.network(
                              "${HttpsClients.replaeUri(controller.rightCategoryList[index].pic)}",
                              fit: BoxFit.fitHeight),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, ScreenAdapter.height(10), 0, 0),
                          child: Text(
                              "${controller.rightCategoryList[index].title}",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(24))),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )));
  }
}
