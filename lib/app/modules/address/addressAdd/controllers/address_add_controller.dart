import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../services/userServices.dart';
import '../../../../services/signServices.dart';
import '../../../../models/user_model.dart';
import '../../../../services/httpsClients.dart';

class AddressAddController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  HttpsClients httpsClients = HttpsClients();
  RxString area = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  setArea(String setArea) {
    area.value = setArea;
    update();
  }

  doAddAddress() async {
    List userList = await UserServices.getUserInfo();
    print(userList);
    UserModel userInfo = UserModel.fromJson(userList[0]);
    if (nameController.text.length < 2) {
      Get.snackbar("提示信息", "请把姓名填写完整");
    } else if (!GetUtils.isPhoneNumber(phoneController.text) ||
        phoneController.text.length != 11) {
      Get.snackbar("提示信息", "手机号不合法");
    } else if (area.value.length < 2) {
      Get.snackbar("提示信息", "请选择地区");
    } else if (addressController.text.length < 2) {
      Get.snackbar("提示信息", "请填写详细的地址");
    } else {
      Map tempJson = {
        "uid": userInfo.sId,
        "name": nameController.text,
        "phone": phoneController.text,
        "address": "${area.value} ${addressController.text}",
      };
      String sign = SignServices.getSign({
        ...tempJson, //合并对象
        "salt": userInfo.salt, //登录成功后服务器返回的salt  私钥
      });
      var response = await httpsClients
          .post("api/addAddress", {...tempJson, "sign": sign});
      if (response.data["success"]) {
        Get.back();
      } else {
        Get.snackbar("提示信息", response.data["message"]);
      }
    }
  }
}
