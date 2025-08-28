import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/productlist_model.dart';
import '../../../services/httpsClients.dart';

class ProductlistController extends GetxController {
  HttpsClients dio = HttpsClients();
  RxList<ProductItem> productlist = <ProductItem>[].obs;
  int page = 1;
  int pageSize = 8;
  String sort = "";
  bool flag = true;
  RxBool hasdata = true.obs;
  RxInt selectHeaderId = 1.obs;
  RxInt subHeaderListSort = 0.obs;
  GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();

  String? keywords = Get.arguments['keywords'];
  String? cid = Get.arguments['cid'];
  String apiUri = '';

  List subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, // 排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];

  @override
  void onInit() {
    super.onInit();
    getproductlistdata();
    initScorllControl();
  }


  void subHeaderChange(id) {
    if (id == 4) {
      selectHeaderId.value = id;
      scaffoldGlobalKey.currentState!.openEndDrawer();
    } else {
      selectHeaderId.value = id;
      //改变排序  sort=price_-1     sort=price_1
      sort =
          "${subHeaderList[id - 1]["fileds"]}_${subHeaderList[id - 1]["sort"]}";
      //改变状态，乘上-1
      subHeaderList[id - 1]["sort"] = subHeaderList[id - 1]["sort"] * -1;
      //作用更新状态（箭头方向改变）
      subHeaderListSort.value = subHeaderList[id - 1]["sort"];
      //重置page
      page = 1;
      //重置数据
      productlist.value = [];
      //重置hasData
      hasdata.value = true;
      //滚动条回到顶部
      scrollController.jumpTo(0);
      //重新请求接口
      getproductlistdata();
    }
  }

  void initScorllControl() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 20) {
        getproductlistdata();
      }
    });
  }

  void getproductlistdata() async {
    if (flag && hasdata.value) {
      flag = false;
      if (cid != null) {
        apiUri = "api/plist?cid=$cid&page=$page&pageSize=$pageSize&sort=$sort";
      } else {
        apiUri =
            "api/plist?search=$keywords&page=$page&pageSize=$pageSize&sort=$sort";
      }
      var response = await dio.get(apiUri);
      if (response != null) {
        var productListData = ProductListModel.fromJson(response.data);
        productlist.addAll(productListData.result!);
        page++;
        update();
        flag = true;
        if (productListData.result!.length < pageSize) {
          hasdata.value = false;
        }
      }
    }
  }
}
