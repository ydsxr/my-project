import 'package:get/get.dart';
import '../../../services/userServices.dart';

class CartController extends GetxController {
  RxBool checkedAll = false.obs;
  checkedBox(value) {
    checkedAll.value = value;
  }

  checkOut() async {
    var response = await UserServices.getUserLoginState();
    if (response) {
      // 这里还需要判断一下购物车中是否有商品
      Get.toNamed('/checkout');
    } else {
      Get.toNamed('/register-step-one');
      Get.snackbar('提示信息！', '还没有登录，请先登录');
    }
  }
}
