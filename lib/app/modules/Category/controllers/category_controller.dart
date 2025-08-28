import '../../../services/httpsClients.dart';
import 'package:get/get.dart';
import '../../../models/category_model.dart';

class CategoryController extends GetxController {
  HttpsClients httpsclients = HttpsClients();
  RxInt selectIndex = 0.obs;
  RxList<CategoryItem> leftCategoryList = <CategoryItem>[].obs;
  RxList<CategoryItem> rightCategoryList = <CategoryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLeftCategoryList();
  }


  void changeSelectIndex(index, id) {
    selectIndex.value = index;
    getRightCategoryList(id);
    update();
  }

  getLeftCategoryList() async {
    var response = await httpsclients.get('api/pcate');
    var leftCategoryListData = CategoryModel.fromJson(response.data);
    leftCategoryList.value = leftCategoryListData.result!;
    // 右侧数据初始化
    getRightCategoryList(leftCategoryList[0].id!);
    update();
  }

  getRightCategoryList(String pid) async {
    var response = await httpsclients.get('api/pcate?pid=$pid');
    var rightCategoryListData = CategoryModel.fromJson(response.data);
    rightCategoryList.value = rightCategoryListData.result!;
    update();
  }
}
