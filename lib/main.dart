import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  //配置透明的状态栏
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(ScreenUtilInit(
    designSize: Size(1080, 2400), 
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    },
  ));
}
