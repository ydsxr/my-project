import 'package:flutter/material.dart';
import '../../../../services/screenAdapter.dart';
import 'package:get/get.dart';
import '../controllers/register_step_one_controller.dart';
import '../../../../widget/logo.dart';
import '../../../../widget/passTextFiled.dart';
import '../../../../widget/passButton.dart';

class RegisterStepOneView extends GetView<RegisterStepOneController> {
  const RegisterStepOneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [TextButton(onPressed: () {}, child: Text("帮助"))],
      ),
      body: ListView(
        children: [
          // logo
          Logo(),
          SizedBox(
            height: ScreenAdapter.height(100),
          ),
          // 输入手机号
          PassTextFiled(
              hintText: "输入手机号",
              // 用于获取输入的手机号
              editingController: controller.editingController,
              onChanged: (value) {}),
          SizedBox(
            height: ScreenAdapter.height(110),
          ),
          PassButton(
              text: ('下一步'),
              onPressed: () async {
                // 判断是否是手机号的方法
                if (GetUtils.isPhoneNumber(controller.editingController.text)) {
                  var response = await controller.sendCode();
                  if (response.success) {
                    Get.offAndToNamed('/register-step-two',
                        arguments: {'tel': controller.editingController.text});
                  } else {
                    Get.snackbar('提示信息！', response.message);
                  }
                } else {
                  Get.snackbar('提示信息！', '手机号格式不合法');
                }
              })
        ],
      ),
    );
  }
}
