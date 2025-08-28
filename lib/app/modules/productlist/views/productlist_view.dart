import 'package:flutter/material.dart';
import '../../../services/httpsClients.dart';

import 'package:get/get.dart';

import '../controllers/productlist_controller.dart';
import '../../../services/screenAdapter.dart';

class ProductlistView extends GetView<ProductlistController> {
  const ProductlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldGlobalKey,
      endDrawer: const Drawer(
        child: DrawerHeader(
          child: Text("右侧筛选"),
        ),
      ),
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Get.toNamed('/search');
          },
          child: Container(
          width: ScreenAdapter.width(900),
          height: ScreenAdapter.height(96),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(34), 0, ScreenAdapter.width(10), 0),
                child: const Icon(Icons.search),
              ),
              Text(
                // 注意非列表变量不为空的判断
                controller.keywords!=null?controller.keywords!:'手机',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenAdapter.fontSize(32)))
            ],
          ),
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // stack使得两个组件叠在一起了，让二阶标题置于顶层
          _productListWidget(),
          _subHeaderWidget(),
          //_productListWidget(),
        ],
      ),
    );
  }

  Widget _subHeaderWidget() {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Obx(() => Container(
              height: ScreenAdapter.height(120),
              width: ScreenAdapter.width(1080),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          width: ScreenAdapter.height(2),
                          color: const Color.fromRGBO(233, 233, 233, 0.9)))),
              child: Row(
                children: controller.subHeaderList.map((value) {
                  return Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                ScreenAdapter.height(16),
                                0,
                                ScreenAdapter.height(16)),
                            child: Text(
                              "${value["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                      controller.selectHeaderId == value["id"]
                                          ? Colors.red
                                          : Colors.black54,
                                  fontSize: ScreenAdapter.fontSize(32)),
                            ),
                          ),
                          onTap: () {
                            controller.subHeaderChange(value["id"]);
                          },
                        ),
                        _showIcon(value["id"])
                      ],
                    ),
                  );
                }).toList(),
              ),
            )));
  }

  Widget _productListWidget() {
    return Obx(() => controller.productlist.isNotEmpty
        ? ListView.builder(
            controller: controller.scrollController,
            padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(26),
                ScreenAdapter.width(140),
                ScreenAdapter.width(26),
                ScreenAdapter.height(26)),
            itemCount: controller.productlist.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenAdapter.height(26)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    //行
                    child: Row(
                      children: [
                        //左侧
                        SizedBox(
                          //padding: EdgeInsets.all(ScreenAdapter.width(40)),
                          width: ScreenAdapter.width(400),
                          height: ScreenAdapter.height(460),
                          child: Image.network(
                              "${HttpsClients.replaeUri(controller.productlist[index].pic)}",
                              fit: BoxFit.fitHeight),
                        ),
                        //右侧
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenAdapter.height(20)),
                              child: Text(
                                  "${controller.productlist[index].title}",
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.fontSize(42),
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenAdapter.height(20)),
                              child: Text(
                                  "${controller.productlist[index].subTitle}",
                                  style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(34),
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: ScreenAdapter.height(20)),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text("CUP",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(34),
                                              fontWeight: FontWeight.bold)),
                                      Text("Helio G25",
                                          style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(34),
                                          ))
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text("高清拍摄",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(34),
                                              fontWeight: FontWeight.bold)),
                                      Text("1300万像素",
                                          style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(34),
                                          ))
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text("超大屏",
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenAdapter.fontSize(34),
                                              fontWeight: FontWeight.bold)),
                                      Text("6.1寸",
                                          style: TextStyle(
                                            fontSize:
                                                ScreenAdapter.fontSize(34),
                                          ))
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            Text("￥${controller.productlist[index].price}起",
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(38),
                                    fontWeight: FontWeight.bold))
                          ],
                        ))
                      ],
                    ),
                  ),
                  (controller.productlist.length - 1) == index
                      ? _progressindicator()
                      : Text(''),
                ],
              );
            })
        : _progressindicator());
  }

  Widget _progressindicator() {
    if (controller.hasdata.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center(
        child: Text('没有数据了喔，我是有底线的'),
      );
    }
  }

//自定义箭头组件
  Widget _showIcon(id) {
    //controller.subHeaderListSort 作用 : 响应式状态  为了改变状态
    if (id == 2 || id == 3) {
      if (controller.subHeaderListSort.value == 1) {
        return const Icon(Icons.arrow_drop_down, color: Colors.black54);
      } else {
        return const Icon(Icons.arrow_drop_up, color: Colors.black54);
      }
    } else {
      return const Text("");
    }
  }
}
