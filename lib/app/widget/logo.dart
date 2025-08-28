import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(
          ScreenAdapter.width(70),
          ScreenAdapter.height(60),
          ScreenAdapter.width(70),
          ScreenAdapter.height(60)),
      child: SizedBox(
        width: ScreenAdapter.width(180),
        height: ScreenAdapter.width(180),
        child: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
      ),
    );
  }
}
