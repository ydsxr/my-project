import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import '../controllers/product_content_controller.dart';

class SecondPageView extends GetView {
  @override
  final ProductContentController controller = Get.find();
  final Function subHeader;
  SecondPageView(this.subHeader, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.globalKey2,
      width: ScreenAdapter.width(1080),
      child: Column(
        children: [
          subHeader(),
          Obx(() => controller.subHeaderSelected == 1
              ? Html(
                    data: controller.pcontent.value.content,
                    style: {
                      "body": Style(backgroundColor: Colors.white),
                      "p": Style(fontSize: FontSize.large),
                    },
                  )
              : Html(
                    data: controller.pcontent.value.specs,
                    style: {
                      "body": Style(backgroundColor: Colors.white),
                      "p": Style(fontSize: FontSize.large),
                    },
                  ))
        ],
      ),
    );
  }
}
