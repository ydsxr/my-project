import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../services/httpsClients.dart';

class RegisterStepTwoController extends GetxController {
  String tel = Get.arguments['tel'];
  HttpsClients httpsClients = HttpsClients();
  TextEditingController editingController = TextEditingController();
  RxInt seconds = 60.obs;

  @override
  void onInit() {
    super.onInit();
    countDown();
  }

  countDown() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      seconds.value--;
      if (seconds.value < 1) {
        timer.cancel();
      }
      update();
    });
  }

  //重新发送验证码
  void sendCode() async {
    var response = await httpsClients
        .post("api/sendCode", {"tel": editingController.text});
    if (response != null) {
      print(response);
      if (response.data["success"]) {
        //测试：把验证码复制到剪切板上面，正式上线不需要这句话,这个为了方便测试
        Clipboard.setData(ClipboardData(text: response.data["code"]));
        seconds.value = 60;
        countDown();
        update();
      }else{
        Get.snackbar("提示信息!", "非法请求");
      }
    } else {
      Get.snackbar("提示信息!", "网络异常请重试");
    }
  }

  //验证验证码
  Future<bool> validateCode() async {
    var response = await httpsClients
        .post('api/validateCode', {'tel': tel, 'code': editingController.text});
    if (response != null) {
      if (response.data['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
