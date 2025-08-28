import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../../../services/screenAdapter.dart';
import './cart_item_view.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('购物车'),
        centerTitle: true,
        actions: [TextButton(onPressed: () {}, child: const Text("编辑"))],
      ),
      body: Stack(
        children: [
          ListView(
            children: const [
              CartItemView(),
              CartItemView(),
              CartItemView(),
              CartItemView(),
              CartItemView(),
              CartItemView(),
              CartItemView(),
              CartItemView(),
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(right: ScreenAdapter.width(20)),
                width: ScreenAdapter.width(1080),
                height: ScreenAdapter.height(190),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Color.fromARGB(178, 240, 236, 236),
                            width: ScreenAdapter.height(2))),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // 复选框
                        Obx(() => Checkbox(
                            value: controller.checkedAll.value,
                            onChanged: (value) {
                              controller.checkedBox(value);
                            })),
                        const Text("全选")
                      ],
                    ),
                    Row(
                      children: [
                        Text("合计: "),
                        Text("¥98.9",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(58),
                                color: Colors.red)),
                        SizedBox(width: ScreenAdapter.width(20)),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    const Color.fromRGBO(255, 165, 0, 0.9)),
                                foregroundColor:
                                    WidgetStateProperty.all(Colors.white),
                                shape: WidgetStateProperty.all(
                                    // CircleBorder()
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            onPressed: () {
                              controller.checkOut();
                            },
                            child: Text("结算"))
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
