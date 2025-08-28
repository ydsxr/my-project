import '../services/storage.dart';

class UserServices {
  // 获取用户信息
  static Future<List> getUserInfo() async {
    List? response = await Storage.getData('userinfo');
    if (response != null) {
      return response;
    } else {
      return [];
    }
  }

  static Future<bool> getUserLoginState() async {
    List userinfo = await getUserInfo();
    if (userinfo.isNotEmpty && userinfo[0]['username'] != '') {
      return true;
    } else {
      return false;
    }
  }

  static loginOut() async {
    Storage.removeData('userinfo');
  }
}
