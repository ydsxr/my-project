import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_content_controller.dart';
import '../../../services/screenAdapter.dart';
import './first_page_view.dart';
import './second_page_view.dart';
import './third_page_view.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 让body在滑动时可以显示在appbar后面
      extendBodyBehindAppBar: true,
      appBar: _appbar(context),
      body: Stack(
        children: [
          _body(),
          _bottom(),
          Obx(() => controller.showSubHeader.value
              ? Positioned(
                  left: 0,
                  top: ScreenAdapter.getStatusBarHeight() +
                      ScreenAdapter.height(160),
                  right: 0,
                  child: _subHeader())
              : Text(''))
        ],
      ),
    );
  }

  PreferredSizeWidget _appbar(context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(ScreenAdapter.height(160)),
      // 没办法给appbar直接套obx
      child: Obx(() => AppBar(
            backgroundColor:
                Colors.white.withValues(alpha: controller.appbarOpacity.value),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                child: SizedBox(
                    width: ScreenAdapter.width(88),
                    height: ScreenAdapter.width(88),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          //注意:去掉button默认的padding
                          padding:
                              WidgetStateProperty.all(const EdgeInsets.all(0)),
                          alignment: Alignment.center,
                          backgroundColor:
                              WidgetStateProperty.all(Colors.black12),
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                          shape: WidgetStateProperty.all(const CircleBorder())),
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                      ),
                    )),
              ),
            ),
            title: Obx(() => controller.showTab.value
                ? SizedBox(
                    width: ScreenAdapter.width(400),
                    height: ScreenAdapter.height(96),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.tabList.map((value) {
                        return Obx(() => InkWell(
                              onTap: () {
                                controller.changetab(value['id']);
                                if (value['id'] == 1) {
                                  // 注意这里是currentContext不是currentState
                                  Scrollable.ensureVisible(
                                      controller.globalKey1.currentContext
                                          as BuildContext,
                                      duration: Duration(milliseconds: 200));
                                } else if (value['id'] == 2) {
                                  Scrollable.ensureVisible(
                                      controller.globalKey2.currentContext
                                          as BuildContext,
                                      duration: Duration(milliseconds: 100));
                                  // //修正,这个方法有问题
                                  // Timer.periodic(
                                  //     const Duration(milliseconds: 120),
                                  //     (timer) {
                                  //   controller.scrollController.jumpTo(
                                  //       controller.scrollController.position
                                  //               .pixels -
                                  //           ScreenAdapter.height(120));
                                  //   timer.cancel();
                                  // });
                                } else {
                                  Scrollable.ensureVisible(
                                      controller.globalKey3.currentContext
                                          as BuildContext,
                                      duration: Duration(milliseconds: 100));
                                  // //修正
                                  // Timer.periodic(
                                  //     const Duration(milliseconds: 101),
                                  //     (timer) {
                                  //   controller.scrollController.jumpTo(
                                  //       controller.scrollController.position
                                  //               .pixels -
                                  //           ScreenAdapter.height(140));
                                  //   timer.cancel();
                                  // });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    ScreenAdapter.width(16),
                                    0,
                                    ScreenAdapter.width(16),
                                    0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${value['tab']}',
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.fontSize(40)),
                                    ),
                                    controller.tabSelected.value == value['id']
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                top: ScreenAdapter.height(10)),
                                            width: ScreenAdapter.width(100),
                                            height: ScreenAdapter.height(10),
                                            color: Colors.red,
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                  )
                : Text('')),
            centerTitle: true,
            actions: [
              //上传按钮
              Container(
                margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                width: ScreenAdapter.width(88),
                height: ScreenAdapter.width(88),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                      backgroundColor: WidgetStateProperty.all(Colors.black12),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(CircleBorder())),
                  child: Icon(
                    Icons.file_upload_outlined,
                    size: ScreenAdapter.fontSize(66),
                  ),
                ),
              ),
              //更多按钮
              Container(
                margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                width: ScreenAdapter.width(88),
                height: ScreenAdapter.width(88),
                child: ElevatedButton(
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            ScreenAdapter.width(880),
                            ScreenAdapter.height(220),
                            ScreenAdapter.width(80),
                            0),
                        color: Colors.black45.withValues(alpha: 0.5),
                        items: [
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.white,
                                ),
                                Text(
                                  '首页',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.message,
                                  color: Colors.white,
                                ),
                                Text(
                                  '消息',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                Text(
                                  '收藏',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ]);
                  },
                  style: ButtonStyle(
                      padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                      backgroundColor: WidgetStateProperty.all(Colors.black12),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(CircleBorder())),
                  child: Icon(
                    Icons.more_horiz_rounded,
                    size: ScreenAdapter.fontSize(66),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _body() {
    // listview具有延迟加载特性，不好实现锚点操作
    //singlechildscrollview默认加载位置在appbar下面
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          FirstPageView(showBottomAttr),
          SecondPageView(_subHeader),
          ThirdPageView(),
        ],
      ),
    );
  }

  Widget _bottom() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: ScreenAdapter.height(200),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      color: Colors.black12, width: ScreenAdapter.width(2)))),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(20), 0, ScreenAdapter.width(100), 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black45,
                    ),
                    Text('购物车',
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(36),
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                child: ElevatedButton(
                    onPressed: () {
                      showBottomAttr();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.yellow),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: Text('加入购物车')),
              )),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                child: ElevatedButton(
                    onPressed: () {
                      showBottomAttr();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: Text(
                      '立即购买',
                    )),
              ))
            ],
          ),
        ));
  }

  void showBottomAttr() {
    Get.bottomSheet(GetBuilder<ProductContentController>(
        init: controller,
        builder: (controller) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            width: double.infinity,
            height: ScreenAdapter.height(1200),
            child: ListView(
              children: controller.pcontent.value.attr!.map((v) {
                return Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenAdapter.height(20),
                          left: ScreenAdapter.width(20)),
                      width: ScreenAdapter.width(1040),
                      child: Text('${v.cate}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenAdapter.height(20),
                          left: ScreenAdapter.width(20)),
                      width: ScreenAdapter.width(1040),
                      child: Wrap(
                        children: v.attrlist!.map((value) {
                          return InkWell(
                            onTap: () {
                              controller.changeAttr(v.cate, value['title']);
                            },
                            child: Container(
                              margin: EdgeInsets.all(ScreenAdapter.width(20)),
                              child: Chip(
                                  padding: EdgeInsets.only(
                                      left: ScreenAdapter.width(20),
                                      right: ScreenAdapter.width(20)),
                                  backgroundColor: value['checked']
                                      ? Colors.red
                                      : const Color.fromARGB(31, 223, 213, 213),
                                  label: Text(value['title'])),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }));
  }

  Widget _subHeader() {
    return Container(
      color: Colors.white.withValues(alpha: 1),
      alignment: Alignment.center,
      child: Row(
        children: controller.subHeaderList.map((v) {
          return Obx(() => Expanded(
                  child: InkWell(
                onTap: () {
                  controller.changeSubHeaderIndex(v['id']);
                },
                child: Container(
                  height: ScreenAdapter.height(140),
                  alignment: Alignment.center,
                  child: Text(
                    v['title'],
                    style: TextStyle(
                        color: controller.subHeaderSelected.value == v['id']
                            ? Colors.red
                            : Colors.black),
                  ),
                ),
              )));
        }).toList(),
      ),
    );
  }
}
