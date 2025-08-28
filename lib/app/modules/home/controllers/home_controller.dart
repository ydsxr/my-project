import 'package:flutter/widgets.dart';
import 'package:flutter02/app/models/productlist_model.dart';
import 'package:get/get.dart';
import '../../../models/focus_model.dart';
import '../../../models/category_model.dart';
import '../../../services/httpsClients.dart';

class HomeController extends GetxController {
  RxBool appbarcolorflag = false.obs;
  ScrollController scrollcontroller = ScrollController();
  // 定义成流数据的好处：远端传输的数据变化时，页面也能重新被渲染
  // 注意这里要定义类型为<FocusItem>，这样dart才能识别里面的属性
  RxList<FocusItem> swiperlist = <FocusItem>[].obs;
  RxList<FocusItem> bestsellingswiperlist = <FocusItem>[].obs;
  RxList<CategoryItem> categorylist = <CategoryItem>[].obs;
  RxList<ProductItem> productlist = <ProductItem>[].obs;
  RxList<ProductItem> bestPlist = <ProductItem>[].obs;
  HttpsClients httpsClients = HttpsClients();

  @override
  void onInit() {
    super.onInit();
    changeappbarcolor();
    getswiperdata();
    getcategorydata();
    getbestsellingswiperdata();
    getproductlistdata();
    getbestplistdata();
  }


  void changeappbarcolor() {
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.pixels > 10) {
        if (appbarcolorflag.value == false) {
          appbarcolorflag.value = true;
          update();
        }
      }
      if (scrollcontroller.position.pixels < 10) {
        if (appbarcolorflag.value == true) {
          appbarcolorflag.value = false;
          update();
        }
      }
    });
  }

  getswiperdata() async {
    // await Future.delayed(Duration(seconds: 10));
    var response = await httpsClients.get("api/focus");
    if (response != null) {
      // 注意这里要.data
      var focusdata = FocusModel.fromJson(response.data);
      //List<FocusItem>? result;注意要加感叹号
      swiperlist.value = focusdata.result!;
      update();
    }
  }

  getcategorydata() async {
    // await Future.delayed(Duration(seconds: 10));
    var response = await httpsClients.get("api/bestCate");
    if (response != null) {
      // 注意这里要.data
      var categorydata = CategoryModel.fromJson(response.data);
      categorylist.value = categorydata.result!;
      update();
    }
  }

  getbestsellingswiperdata() async {
    var response = await httpsClients.get("api/focus?position=2");
    // 注意这里要.data
    if (response != null) {
      var bestsellingswiperdata = FocusModel.fromJson(response.data);
      bestsellingswiperlist.value = bestsellingswiperdata.result!;
      update();
    }
  }

  getproductlistdata() async {
    var response = await httpsClients.get("api/plist?is_hot=1&pageSize=3");
    // 注意这里要.data
    if (response != null) {
      var productlistdata = ProductListModel.fromJson(response.data);
      productlist.value = productlistdata.result!;
      update();
    }
  }

  getbestplistdata() async {
    var response = await httpsClients.get("api/plist?is_best=1");
    // 注意这里要.data
    if (response != null) {
      var bestplistdata = ProductListModel.fromJson(response.data);
      bestPlist.value = bestplistdata.result!;
      update();
    }
  }
}
