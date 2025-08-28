import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class PassButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const PassButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenAdapter.width(60),ScreenAdapter.height(50),ScreenAdapter.width(60),0),
      height: ScreenAdapter.height(140),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(Color.fromRGBO(240, 115, 49, 1)),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ScreenAdapter.height(70))))),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: ScreenAdapter.fontSize(46)),
        ),
      ),
    );
  }
}
