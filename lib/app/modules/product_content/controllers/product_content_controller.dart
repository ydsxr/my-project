import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../models/pcontent_model.dart';
import '../../../services/httpsClients.dart';
import '../../../services/screenAdapter.dart';

class ProductContentController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxDouble appbarOpacity = 0.0.obs;
  GlobalKey globalKey1 = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();
  HttpsClients httpsClients = HttpsClients();
  // 注意这个模型类返回的不是列表，而是直接item model
  var pcontent = PcontentItemModel().obs;
  //var pcontentAttr = PcontentItemModel().attr.obs;
  RxBool showSubHeader = false.obs;
  List tabList = [
    {'id': 1, 'tab': '商品'},
    {'id': 2, 'tab': '详情'},
    {'id': 3, 'tab': '推荐'}
  ];
  List subHeaderList = [
    {'id': 1, 'title': '商品介绍'},
    {'id': 2, 'title': '规格参数'}
  ];
  RxInt tabSelected = 1.obs;
  RxInt subHeaderSelected = 1.obs;
  RxBool showTab = false.obs;
  //详情 container的位置
  double gk2Position = 0;
  double gk3Position = 0;
  @override
  void onInit() {
    super.onInit();
    changeOpacity();
    getContentData();
  }

  changeOpacity() {
    scrollController.addListener(() {
      if (gk2Position == 0 && gk3Position == 0) {
        getContainerPosition(scrollController.position.pixels);
      }
      if (scrollController.position.pixels > gk2Position &&
          scrollController.position.pixels < gk3Position) {
        if (showSubHeader.value == false) {
          showSubHeader.value = true;
          tabSelected.value = 2;
          update();
        }
      } else if (scrollController.position.pixels > 0 &&
          scrollController.position.pixels < gk2Position) {
        if (showSubHeader.value == true) {
          showSubHeader.value = false;
          tabSelected.value = 1;
          update();
        }
      } else if (scrollController.position.pixels > gk3Position) {
        if (showSubHeader.value == true) {
          showSubHeader.value = false;
          tabSelected.value = 3;
          update();
        }
      }
      //控制顶部bar的透明度
      if (scrollController.position.pixels <= 150) {
        appbarOpacity.value = scrollController.position.pixels / 150;
        if (showTab.value == true) {
          showTab.value = false;
        }
        update();
      } else {
        appbarOpacity.value = 1;
        if (showTab.value == false) {
          showTab.value = true;
        }
        update();
      }
    });
  }

  changetab(index) {
    tabSelected.value = index;
    update();
  }

  changeSubHeaderIndex(index) {
    subHeaderSelected.value = index;
    scrollController.jumpTo(gk2Position);
    update();
  }

  getContentData() async {
    var response =
        await httpsClients.get('api/pcontent?id=${Get.arguments["id"]}');
    var tempData = PcontentModel.fromJson(response.data);
    pcontent.value = tempData.result!; //.result见模型类
    //pcontentAttr.value = tempData.result!.attr;
    initAttr(pcontent.value.attr);
    //initAttr(pcontentAttr.value);
    update();
  }

  initAttr(List<PcontentAttrModel>? attr) {
    for (var i = 0; i < attr!.length; i++) {
      for (var j = 0; j < attr[i].list!.length; j++) {
        if (j == 0) {
          attr[i].attrlist!.add({'title': attr[i].list![j], 'checked': true});
        } else {
          attr[i].attrlist!.add({'title': attr[i].list![j], 'checked': false});
        }
      }
    }
  }

  changeAttr(cate, title) {
    for (var i = 0; i < pcontent.value.attr!.length; i++) {
      if (pcontent.value.attr![i].cate == cate) {
        for (var j = 0; j < pcontent.value.attr![i].list!.length; j++) {
          pcontent.value.attr![i].attrlist![j]['checked'] = false;
          if (pcontent.value.attr![i].attrlist![j]['title'] == title) {
            pcontent.value.attr![i].attrlist![j]['checked'] = true;
          }
        }
      }
    }
    update();
  }

  getContainerPosition(double pixels) {
    RenderBox box2 = globalKey2.currentContext!.findRenderObject() as RenderBox;
    gk2Position = box2.localToGlobal(Offset.zero).dy +
        pixels -
        (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(158));
    RenderBox box3 = globalKey3.currentContext!.findRenderObject() as RenderBox;
    gk3Position = box3.localToGlobal(Offset.zero).dy +
        pixels -
        (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(158));
  }
}
