import 'package:flutter/widgets.dart';
import '../../../../services/storage.dart';
import 'package:get/get.dart';
import '../../../../services/httpsClients.dart';
import '../../../../models/message_model.dart';
import '../../../user/controllers/user_controller.dart';

class RegisterStepThreeController extends GetxController {
  HttpsClients httpsClients = HttpsClients();
  var tel = Get.arguments['tel'];
  var code = Get.arguments['code'];
  TextEditingController editingPassword = TextEditingController();
  TextEditingController editingConfirmPassword = TextEditingController();
  // 实例化是不行的，实例化是浅拷贝，异步调用控制器要用Get.find();
  // UserController userController = UserController();
  UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    userController.getUserData();
    super.onClose();
  }

  Future<MessageModel> doRegister() async {
    var response = await httpsClients.post("api/register",
        {"tel": tel, 'code': code, 'password': editingPassword.text});
    if (response != null) {
      print(response);
      if (response.data["success"]) {
        // 保存用户信息至本地存储
        Storage.setData('userinfo', response.data['userinfo']);
        return MessageModel(message: '注册成功', success: true);
      }
      return MessageModel(message: response.data['message'], success: false);
    } else {
      return MessageModel(message: '网络异常', success: false);
    }
  }
}
