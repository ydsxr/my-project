import 'package:flutter/material.dart';
import 'package:flutter02/app/widget/passButton.dart';
import 'package:get/get.dart';
import '../controllers/register_step_three_controller.dart';
import '../../../../widget/logo.dart';
import '../../../../widget/passTextFiled.dart';
import '../../../../models/message_model.dart';

class RegisterStepThreeView extends GetView<RegisterStepThreeController> {
  const RegisterStepThreeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("手机号快速注册"),
        actions: [TextButton(onPressed: () {}, child: Text("帮助"))],
      ),
      body: ListView(
        children: [
          Logo(),
          PassTextFiled(
            hintText: '输入密码',
            keyboardType: TextInputType.text,
            onChanged: (v) {},
            editingController: controller.editingPassword,
          ),
          PassTextFiled(
            hintText: '确认密码',
            keyboardType: TextInputType.text,
            onChanged: (v) {},
            editingController: controller.editingConfirmPassword,
          ),
          PassButton(
              text: '完成注册',
              onPressed: () async {
                if (controller.editingPassword.text !=
                    controller.editingConfirmPassword.text) {
                  Get.snackbar('提示信息', '两次输入的密码不一致');
                } else if (controller.editingPassword.text.length < 6) {
                  Get.snackbar('提示信息', '密码长度不能小于6');
                } else {
                  MessageModel result = await controller.doRegister();
                  if (result.success) {
                    Get.back();
                  } else {
                    Get.snackbar('提示信息', result.message);
                  }
                }
              })
        ],
      ),
    );
  }
}
