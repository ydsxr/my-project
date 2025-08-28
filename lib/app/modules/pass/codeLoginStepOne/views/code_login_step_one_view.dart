import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/code_login_step_one_controller.dart';
import '../../../../widget/logo.dart';
import '../../../../widget/passTextFiled.dart';
import '../../../../widget/userAgreement.dart';
import '../../../../widget/passButton.dart';

class CodeLoginStepOneView extends GetView<CodeLoginStepOneController> {
  const CodeLoginStepOneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [TextButton(onPressed: () {}, child: Text("帮助"))],
      ),
      body: Center(
        child: ListView(
          children: [
            // logo
            Logo(),
            // 输入手机号
            PassTextFiled(
                hintText: "请输入手机号",
                // 用于获取输入文本框的值
                editingController: controller.editingController,
                onChanged: (value) {
                  print(value);
                }),
            PassTextFiled(
                hintText: "密码",
                onChanged: (value) {
                  print(value);
                }),
            UserAgreement(),
            PassButton(
                text: ('获取验证码'),
                onPressed: () {
                  Get.toNamed('/code-login-step-two');
                })
          ],
        ),
      ),
    );
  }
}
