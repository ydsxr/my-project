import 'package:get/get.dart';
import '../../../services/userServices.dart';
import '../../../models/user_model.dart';

class UserController extends GetxController {
  RxBool userLoginState = false.obs;
  Rx<UserModel> userInfo = UserModel().obs;
  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  getUserData() async {
    var tempLoginState = await UserServices.getUserLoginState();
    userLoginState.value = tempLoginState;
    var tempInfoList = await UserServices.getUserInfo();
    if (tempInfoList != []) {
      userInfo.value = UserModel.fromJson(tempInfoList[0]);
      update();
    }
  }

  loginOut() {
    UserServices.loginOut();
    userInfo.value = UserModel();
    userLoginState.value = false;
    update();
  }
}
