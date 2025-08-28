import 'package:flutter/material.dart';
import '../../../services/httpsClients.dart';
import '../../../services/screenAdapter.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../services/keepAliveWrapper.dart';
import '../../../services/storyfonts.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
      body: Stack(children: [_body(), _appbar()]),
    ));
  }

  Widget _appbar() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Obx(
          () => AppBar(
            backgroundColor: controller.appbarcolorflag.value
                ? Colors.white
                : Colors.transparent,
            title: InkWell(
              onTap: () {
                Get.toNamed('/search');
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: controller.appbarcolorflag.value
                    ? ScreenAdapter.width(800)
                    : ScreenAdapter.width(620),
                height: ScreenAdapter.height(96),
                decoration: BoxDecoration(
                    color: Color.fromARGB(237, 252, 243, 236),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(ScreenAdapter.width(34), 0, 0, 0),
                      child: Text(
                        '手机',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenAdapter.width(36)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            centerTitle: true,
            elevation: 0,
            leading: controller.appbarcolorflag.value
                ? Text('')
                : Icon(
                    Storyfonts.xiaomi,
                    color: Colors.white,
                  ),
            leadingWidth: controller.appbarcolorflag.value
                ? ScreenAdapter.width(40)
                : ScreenAdapter.width(140),
            actions: [
              Icon(
                Icons.qr_code,
                color: controller.appbarcolorflag.value
                    ? Colors.black54
                    : Colors.white,
              ),
              Icon(
                Icons.message,
                color: controller.appbarcolorflag.value
                    ? Colors.black54
                    : Colors.white,
              ),
            ],
          ),
        ));
  }

  Widget _body() {
    return Positioned(
      // 没有appbar，则body默认从顶部布局，这里-40是图片上半截有点多余了
      top: -40,
      left: 0,
      right: 0,
      bottom: 0,
      child: ListView(
        controller: controller.scrollcontroller,
        children: [
          _focus(),
          _banner1(),
          _category(),
          _banner2(),
          _bestSelling(),
          _bestGoods(),
          SizedBox(
            height: ScreenAdapter.height(500),
          )
        ],
      ),
    );
  }

//body中的组件
  Widget _focus() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(682),
      child: Obx(() => Swiper(
            itemBuilder: (context, swiperindex) {
              return Image.network(
                HttpsClients.replaeUri(controller.swiperlist[swiperindex].pic),
                fit: BoxFit.fill,
              );
            },
            itemCount: controller.swiperlist.length,
            //轮播图下的点的显示形状
            pagination: const SwiperPagination(builder: SwiperPagination.rect),
            autoplay: true,
            // 去掉左右滑动的箭头，去掉control
            // control: const SwiperControl(),
          )),
    );
  }

  Widget _banner1() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(92),
      child: Image.asset(
        'assets/images/xiaomiBanner.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _category() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(470),
      child: Obx(() => Swiper(
            //除以10取整
            itemCount: controller.categorylist.length ~/ 10,
            autoplay: true,
            pagination: SwiperPagination(
                margin: const EdgeInsets.all(0.0),
                builder: SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                  return ConstrainedBox(
                    constraints:
                        BoxConstraints.expand(height: ScreenAdapter.height(20)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: const RectSwiperPaginationBuilder(
                              color: Colors.black12,
                              activeColor: Colors.black54,
                            ).build(context, config),
                          ),
                        )
                      ],
                    ),
                  );
                })),
            itemBuilder: (context, swiperindex) {
              return GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: ScreenAdapter.width(20)),
                  itemBuilder: (context, gridviewindex) {
                    return Column(
                      children: [
                        SizedBox(
                          width: ScreenAdapter.width(140),
                          height: ScreenAdapter.height(140),
                          child: Image.network(
                            HttpsClients.replaeUri(controller
                                .categorylist[
                                    gridviewindex + (swiperindex * 10)]
                                .pic),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, ScreenAdapter.height(4), 0, 0),
                          child: Text(
                            '${controller.categorylist[gridviewindex + (swiperindex * 10)].title}',
                            style:
                                TextStyle(fontSize: ScreenAdapter.fontSize(34)),
                          ),
                        ),
                      ],
                    );
                  });
            },
          )),
    );
  }

  Widget _banner2() {
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
          ScreenAdapter.height(20), ScreenAdapter.width(20), 0),
      child: Container(
        height: ScreenAdapter.height(420),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
          image: const DecorationImage(
              image: AssetImage('assets/images/xiaomiBanner2.png'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _bestSelling() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(30),
                ScreenAdapter.height(40),
                ScreenAdapter.width(30),
                ScreenAdapter.height(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("热销臻选",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenAdapter.fontSize(46))),
                Text("更多手机推荐 >",
                    style: TextStyle(fontSize: ScreenAdapter.fontSize(38)))
              ],
            )),
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), 0,
              ScreenAdapter.width(20), ScreenAdapter.height(20)),
          child: Row(
            children: [
              //左侧
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: ScreenAdapter.height(738),
                    child: Obx(() => Swiper(
                        itemBuilder: (context, index) {
                          return Image.network(
                            HttpsClients.replaeUri(
                                controller.bestsellingswiperlist[index].pic),
                            fit: BoxFit.fill,
                          );
                        },
                        itemCount: controller.bestsellingswiperlist.length,
                        autoplay: true,
                        loop: true,
                        pagination: SwiperPagination(
                            margin: const EdgeInsets.all(0.0),
                            builder: SwiperCustomPagination(builder:
                                (BuildContext context,
                                    SwiperPluginConfig config) {
                              return ConstrainedBox(
                                constraints: BoxConstraints.expand(
                                    height: ScreenAdapter.height(36)),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child:
                                            const RectSwiperPaginationBuilder(
                                          color: Colors.black12,
                                          activeColor: Colors.black54,
                                        ).build(context, config),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })))),
                  )),
              SizedBox(width: ScreenAdapter.width(20)),
              //右侧
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: ScreenAdapter.height(738),
                    child: Obx(() => Column(
                          children: controller.productlist
                              .asMap()
                              .entries
                              .map((entrie) {
                            var item = entrie.value;
                            return Expanded(
                                flex: 1,
                                child: Container(
                                    color:
                                        const Color.fromRGBO(246, 246, 246, 1),
                                    margin: EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        entrie.key == 2
                                            ? 0
                                            : ScreenAdapter.height(20)),
                                    child: Row(children: [
                                      // 右边左侧
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height:
                                                    ScreenAdapter.height(40)),
                                            Text("${item.title}",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            25),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                                height:
                                                    ScreenAdapter.height(18)),
                                            Text("${item.subTitle}",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            20))),
                                            SizedBox(
                                                height:
                                                    ScreenAdapter.height(18)),
                                            Text("众筹价￥${item.price}元",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            22)))
                                          ],
                                        ),
                                      ),
                                      // 右边右侧
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              ScreenAdapter.height(8)),
                                          child: Image.network(
                                              HttpsClients.replaeUri(item.pic),
                                              fit: BoxFit.cover),
                                        ),
                                      )
                                    ])));
                          }).toList(),
                        )),
                  )),
            ],
          ),
        )
      ],
    );
  }

  Widget _bestGoods() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(30),
              ScreenAdapter.height(40),
              ScreenAdapter.width(30),
              ScreenAdapter.height(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '省心优惠',
                style: TextStyle(
                    fontSize: ScreenAdapter.fontSize(36),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '全部优惠 >',
                style: TextStyle(
                  fontSize: ScreenAdapter.fontSize(26),
                ),
              ),
            ],
          ),
        ),
        Obx(() => Container(
              padding: EdgeInsets.all(ScreenAdapter.width(26)),
              color: const Color.fromRGBO(246, 246, 246, 1),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: ScreenAdapter.width(26),
                crossAxisSpacing: ScreenAdapter.height(26),
                itemCount: controller.bestPlist.length,

                ///收缩，让元素宽度自适应
                shrinkWrap: true,
                // 禁止左右滑动
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed('/product-content',arguments: {'id':controller.bestPlist[index].id});
                    },
                    child: Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(20)),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ScreenAdapter.width(20)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            child: Image.network(
                              HttpsClients.replaeUri(
                                  controller.bestPlist[index].pic),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            width: double.infinity,
                            child: Text(
                              "${controller.bestPlist[index].title}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(30),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            width: double.infinity,
                            child: Text(
                              "${controller.bestPlist[index].subTitle}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(24),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            width: double.infinity,
                            child: Text(
                              "${controller.bestPlist[index].price}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(28),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )),
      ],
    );
  }
}
