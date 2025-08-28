import 'package:flutter/material.dart';
import '../../../services/storyfonts.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../../../services/screenAdapter.dart';
import '../../../widget/passButton.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 230, 238, 1),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Text('会员码'),
          IconButton(onPressed: () {}, icon: Icon(Icons.qr_code_2_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.message_outlined)),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // 登录/注册/显示用户信息
          Obx(()=>controller.userLoginState.value
              ? InkWell(
                  onTap: () {
                    
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: ScreenAdapter.width(50)),
                    child: Row(
                      children: [
                        SizedBox(
                          child: CircleAvatar(
                            radius: ScreenAdapter.width(75),
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          ),
                        ),
                        SizedBox(
                          width: ScreenAdapter.width(40),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${controller.userInfo.value.username}'),
                            SizedBox(
                              height: ScreenAdapter.height(20),
                            ),
                            Text('普通会员'),
                          ],
                        ),
                        SizedBox(
                          width: ScreenAdapter.width(40),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    Get.toNamed('/register-step-one');
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: ScreenAdapter.width(50)),
                    child: Row(
                      children: [
                        SizedBox(
                          child: CircleAvatar(
                            radius: ScreenAdapter.width(75),
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          ),
                        ),
                        SizedBox(
                          width: ScreenAdapter.width(40),
                        ),
                        Text("登录/注册",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(46))),
                        SizedBox(
                          width: ScreenAdapter.width(40),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                )),
          // 米金/优惠券/红包/最高额度/钱包
          Container(
            height: ScreenAdapter.height(160),
            margin: EdgeInsets.only(top: ScreenAdapter.height(50)),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '--',
                          style:
                              TextStyle(fontSize: ScreenAdapter.fontSize(48)),
                        ),
                        Text(
                          '米金',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenAdapter.fontSize(34)),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '--',
                          style:
                              TextStyle(fontSize: ScreenAdapter.fontSize(48)),
                        ),
                        Text(
                          '优惠券',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenAdapter.fontSize(34)),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '--',
                          style:
                              TextStyle(fontSize: ScreenAdapter.fontSize(48)),
                        ),
                        Text(
                          '红包',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenAdapter.fontSize(34)),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '--',
                          style:
                              TextStyle(fontSize: ScreenAdapter.fontSize(48)),
                        ),
                        Text('最高额度',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenAdapter.fontSize(34),
                            ))
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Icon(Icons.bookmarks_outlined),
                        ),
                        Text(
                          '钱包',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenAdapter.fontSize(34)),
                        )
                      ],
                    )),
              ],
            ),
          ),
          //广告
          Padding(
            padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
                ScreenAdapter.height(20), ScreenAdapter.width(20), 0),
            child: Image.asset('assets/images/user_ad1.png'),
          ),
          //收藏/足迹/关注
          Container(
            height: ScreenAdapter.height(370),
            margin: EdgeInsets.fromLTRB(
                ScreenAdapter.width(36),
                ScreenAdapter.height(20),
                ScreenAdapter.width(36),
                ScreenAdapter.height(20)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: ScreenAdapter.height(96),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            height: ScreenAdapter.height(70),
                            child: Text(
                              '收藏',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(36)),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            height: ScreenAdapter.height(70),
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      width: ScreenAdapter.width(4),
                                      color: Colors.black12),
                                  right: BorderSide(
                                      width: ScreenAdapter.width(4),
                                      color: Colors.black12)),
                            ),
                            child: Text(
                              '足迹',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(36)),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            height: ScreenAdapter.height(70),
                            child: Text(
                              '关注',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(36)),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenAdapter.width(30), 0, ScreenAdapter.width(30), 0),
                  child: Divider(
                    height: ScreenAdapter.height(6),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
                      ScreenAdapter.height(20), ScreenAdapter.width(20), 0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmarks_outlined)),
                          Text(
                            '待付款',
                            style:
                                TextStyle(fontSize: ScreenAdapter.fontSize(32)),
                          )
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.car_crash)),
                          Text('待收货',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(32)))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.question_answer_outlined)),
                          Text('待评价',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(32)))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.design_services_outlined)),
                          Text('退换/售后',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(32)))
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.copy_all_rounded)),
                          Text('全部订单',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(32)))
                        ],
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
          // 服务
          Container(
            height: ScreenAdapter.height(560),
            margin: EdgeInsets.only(
                top: ScreenAdapter.height(10),
                left: ScreenAdapter.width(36),
                right: ScreenAdapter.width(36),
                bottom: ScreenAdapter.height(10)),
            padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(50),
                ScreenAdapter.height(30),
                ScreenAdapter.width(50),
                ScreenAdapter.height(30)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenAdapter.width(30))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '服务',
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(44)),
                    ),
                    Row(
                      children: [
                        Text(
                          '查看更多',
                          style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(40),
                              color: Colors.black45),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: ScreenAdapter.fontSize(50),
                          color: Colors.black45,
                        )
                      ],
                    )
                  ],
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  childAspectRatio: 1.253,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Storyfonts.anzhuangyewu,
                          color: Colors.blue,
                          size: ScreenAdapter.fontSize(60),
                        ),
                        Text("一键安装",
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(36),
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Storyfonts.tuihuanhuo,
                          color: Colors.orange,
                          size: ScreenAdapter.fontSize(60),
                        ),
                        Text("一键退换",
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(36),
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Storyfonts.weixiu,
                          color: Colors.purple,
                          size: ScreenAdapter.fontSize(60),
                        ),
                        Text("一键维修",
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(36),
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Storyfonts.schedule,
                          color: Colors.orange,
                          size: ScreenAdapter.fontSize(60),
                        ),
                        Text("服务进度",
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(36),
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Storyfonts.xiaomi,
                          color: Colors.orange,
                          size: ScreenAdapter.fontSize(60),
                        ),
                        Text("小米之家",
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(36),
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Storyfonts.kefu,
                          color: Colors.orange,
                          size: ScreenAdapter.fontSize(60),
                        ),
                        Text("客服中心",
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(36),
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Storyfonts.duihuan,
                          color: Colors.green,
                          size: ScreenAdapter.fontSize(60),
                        ),
                        Text("以旧换新",
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(36),
                            ))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Storyfonts.chongdian,
                          color: Colors.green,
                          size: ScreenAdapter.fontSize(60),
                        ),
                        Text("手机电池",
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(36),
                            ))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          //底部广告
          Padding(
            padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
                ScreenAdapter.height(20), ScreenAdapter.width(20), 0),
            child: Image.asset('assets/images/user_ad2.png'),
          ),
          //退出登录
          PassButton(
              text: '退出登录',
              onPressed: () {
                controller.loginOut();
              })
        ],
      ),
    );
  }
}
