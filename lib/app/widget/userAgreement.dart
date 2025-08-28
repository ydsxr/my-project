import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class UserAgreement extends StatelessWidget {
  const UserAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenAdapter.width(60),ScreenAdapter.height(10),ScreenAdapter.width(60),0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children:<Widget>[
          Transform.scale(
            alignment: Alignment.centerRight,
            scale: 0.60,
            child: Checkbox(
            value: false,
            onChanged: (v) {},
            shape: CircleBorder(),
            checkColor: Colors.red,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          ),
          Text(
            "已阅读并同意",
            style: TextStyle(fontSize: ScreenAdapter.fontSize(30)),
          ),
          Text(
            "《商城用户协议》",
            style: TextStyle(
                color: Colors.red, fontSize: ScreenAdapter.fontSize(30)),
          ),
          Text(
            "《商城用户协议》",
            style: TextStyle(
                color: Colors.red, fontSize: ScreenAdapter.fontSize(30)),
          ),
          Text("《商城隐私协议》",
              style: TextStyle(
                  color: Colors.red, fontSize: ScreenAdapter.fontSize(30))),
        ],
      ),
    );
  }
}
