import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton(
      {super.key,
      this.color = Colors.transparent,
      this.textColor = Colors.black,
      this.borderRadius = 44.0,
      this.width = 144.0,
      this.height = 44.0,
      this.marginTop = 8.0,
        this.isLoading = false,
      required this.onPressed,
      required this.text});

  final Color? color;
  final Color? textColor;
  final VoidCallback onPressed;
  final String text;
  final double borderRadius;
  final double marginTop;
  final double height;
  final double width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: marginTop),
      alignment: Alignment.center,
      child: isLoading ? const CircularProgressIndicator() : InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius), color: color),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor),
          ),
        ),
      ),
    );
  }
}
