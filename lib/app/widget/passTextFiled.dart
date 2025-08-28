import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class PassTextFiled extends StatelessWidget {
  final bool isPassword;
  final String hintText;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final TextEditingController? editingController;
  const PassTextFiled(
      {super.key,
      required this.hintText,
      this.onChanged,
      this.keyboardType = TextInputType.number,
      this.isPassword = false,
      this.editingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: ScreenAdapter.height(188),
      margin: EdgeInsets.fromLTRB(ScreenAdapter.width(60),
          ScreenAdapter.height(34), ScreenAdapter.width(60), 0),
      padding: EdgeInsets.only(left: ScreenAdapter.width(40)),
      decoration: BoxDecoration(
          color: Color.fromRGBO(240, 240, 240, 1),
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        // autofocus: true,
        controller: editingController,
        obscureText: isPassword, //显示是否是密码框
        style: TextStyle(fontSize: ScreenAdapter.fontSize(48)),
        keyboardType: keyboardType, //默认弹出数字键盘
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Color.fromRGBO(126, 126, 126, 1)),
            border: InputBorder.none //去掉下划线
            ),
        onChanged: onChanged,
      ),
    );
  }
}
