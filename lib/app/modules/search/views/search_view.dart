import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

import '../../../services/screenAdapter.dart';

import '../../../services/searchServices.dart';

class SearchView extends GetView<SearchpageController> {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: _appbar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appbar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      title: Container(
          width: ScreenAdapter.width(840),
          height: ScreenAdapter.height(96),
          decoration: BoxDecoration(
              color: Color.fromRGBO(246, 246, 246, 1),
              borderRadius: BorderRadius.circular(ScreenAdapter.width(30))),
          // 使用textfield
          child: TextField(
            //页面加载时自动弹出输入框
            autofocus: true,
            style: TextStyle(fontSize: ScreenAdapter.fontSize(36)),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(30)),
                    borderSide: BorderSide.none)),
            // 接收键盘传入的值
            onChanged: (value) {
              controller.keywords = value;
            },
            // 监听键盘回车事件
            onSubmitted: (value) {
              //保存历史搜索记录
              SearchServices.setHistoryData(value);
              Get.offAndToNamed('/productlist', arguments: {'keywords': value});
            },
          )),
      centerTitle: true,
      actions: [
        TextButton(
            onPressed: () {
              //保存历史搜索记录
              SearchServices.setHistoryData(controller.keywords);
              Get.offAndToNamed('/productlist',
                  arguments: {'keywords': controller.keywords});
            },
            child: Text('搜索',
                style: TextStyle(
                  fontSize: ScreenAdapter.fontSize(36),
                ))),
      ],
    );
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),0,ScreenAdapter.width(20),ScreenAdapter.width(20)),
      children: [
        Obx(()=>controller.historyList.isNotEmpty?Container(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('搜素历史',
                  style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(36),
                      fontWeight: FontWeight.bold)),
              IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                        title: '提示信息',
                        middleText: '是否清空历史记录？',
                        confirm: ElevatedButton(
                            onPressed: () {
                              controller.clearHistoryData();
                              Get.back();
                            },
                            child: Text('确定')),
                        cancel: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('取消')));
                  },
                  icon: Icon(Icons.delete_forever_outlined)),
            ],
          ),
        ):Text('',style:TextStyle(fontSize: 0),)),
        Padding(
            padding: EdgeInsets.only(bottom: ScreenAdapter.width(20)),
            child: Obx(
              () => Wrap(
                // 长按删除操作
                children: controller.historyList
                    .map((value) => GestureDetector(
                          onLongPress: () {
                            //首先弹出对话框
                            Get.defaultDialog(
                                title: '提示信息',
                                middleText: '删除该条记录？',
                                confirm: ElevatedButton(
                                    onPressed: () {
                                      controller.removeHistoryData(value);
                                      Get.back();
                                    },
                                    child: Text('确定')),
                                cancel: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('取消')));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdapter.width(20),
                                ScreenAdapter.height(15),
                                ScreenAdapter.width(20),
                                ScreenAdapter.height(15)),
                            margin: EdgeInsets.all(ScreenAdapter.height(16)),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(246, 246, 246, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(value),
                          ),
                        ))
                    .toList(),
              ),
            )),
        Container(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('猜你想搜',
                  style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(36),
                      fontWeight: FontWeight.bold)),
              Icon(Icons.refresh),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(20),
                    ScreenAdapter.height(15),
                    ScreenAdapter.width(20),
                    ScreenAdapter.height(15)),
                color: Color.fromRGBO(246, 246, 246, 1),
                child: Text('data'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
