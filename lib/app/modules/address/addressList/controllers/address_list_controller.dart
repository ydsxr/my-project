import 'package:get/get.dart';
import '../../../../services/httpsClients.dart';
import '../../../../services/userServices.dart';
import '../../../../models/user_model.dart';
import '../../../../services/signServices.dart';
import '../../../../models/address_model.dart';

class AddressListController extends GetxController {
  HttpsClients httpsClients = HttpsClients();
  RxList<AddressItemModel> addressList = <AddressItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getAddressList() async {
    List userList = await UserServices.getUserInfo();
    print(userList);
    UserModel userInfo = UserModel.fromJson(userList[0]);
    Map tempJson = {
      "uid": userInfo.sId,
    };
    String sign = SignServices.getSign({
      ...tempJson, //合并对象
      "salt": userInfo.salt, //登录成功后服务器返回的salt  私钥
    });
    var response =
        await httpsClients.get("api/addressList&uid=${userInfo.sId}&sign=$sign");
    if (response != null) {
      var tempList = AddressModel.fromJson(response.data);
      addressList.value = tempList.result!;
      update();
    }
  }
}
