import 'package:get/get.dart';
import '../../../services/searchServices.dart';
import '../../../services/storage.dart';

class SearchpageController extends GetxController {
  String keywords = '';
  RxList historyList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getHistoryData();
  }

  getHistoryData() async {
    var tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      // 储存历史记录
      historyList.addAll(tempList);
      update();
    }
  }

  removeHistoryData(String keywords) async {
    var tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      tempList.remove(keywords);
      //本地数据更新
      await Storage.setData("searchList", tempList);
      //注意
      historyList.remove(keywords);
      update();
    }
  }

  clearHistoryData()async{
    await SearchServices.clearHistoryData();
    historyList.clear();
    update();
  }
}
