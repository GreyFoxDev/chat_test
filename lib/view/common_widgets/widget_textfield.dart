import 'package:flutter/material.dart';

class WidgetTextField extends StatelessWidget {
  const WidgetTextField({
    super.key,
    required this.controller,
    this.hint = "",
    this.borderRadius = 6.0,
    this.inputType = TextInputType.text,
    this.isObscure = false,
    this.marginVertical = 4.0,
    this.marginHorizontal = 0.0,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final bool isObscure;
  final bool readOnly;
  final double marginVertical;
  final double marginHorizontal;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        obscureText: isObscure,
        cursorHeight: 16.0,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: " $hint",
          border: InputBorder.none,
          isDense: true,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.0),
        ),
      ),
    );
  }
}
