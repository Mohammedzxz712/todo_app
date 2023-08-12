import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  TextStyle? style;
  double? width;
  double? height;
  final BoxDecoration decoration;
  final VoidCallback onPressed;

  CustomButton({
    Key? key,
    this.width,
    this.style,
    this.height,
    this.padding,
    this.margin,
    required this.text,
    required this.onPressed,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      padding: padding,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
