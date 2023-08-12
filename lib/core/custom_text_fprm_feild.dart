import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/constant/colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.isPassword,
      this.type,
      this.controller,
      this.validate,
      this.label,
      this.onTap,
      this.suffixIcon,
      this.suffixPressed,
      this.border,
      this.edgeInsetsGeometry,
      this.hint,
      this.onChanged,
      this.onSubmitted,
      this.prefixIcon,
      this.labelStyle,
      this.hintStyle,
      this.enabledBorder,
      this.focusedBorder});

  bool? isPassword;
  TextInputType? type;
  TextEditingController? controller;
  String? Function(String?)? onSubmitted;
  String? Function(String?)? onChanged;
  String? Function(String?)? validate;
  String? hint;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Function? onTap;
  Function? suffixPressed;
  InputBorder? border;
  InputBorder? focusedBorder;
  InputBorder? enabledBorder;
  EdgeInsetsGeometry? edgeInsetsGeometry;
  String? label;
  TextStyle? hintStyle;
  TextStyle? labelStyle;

  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword!,
      keyboardType: type,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      validator: validate,
      onTap: () {
        onTap;
      },
      decoration: InputDecoration(
        helperStyle:
            const TextStyle(decorationStyle: TextDecorationStyle.dotted),
        contentPadding: edgeInsetsGeometry,
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
        ),
        border: border,
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        hintStyle: GoogleFonts.aBeeZee(color: Colors.grey),
        hintText: hint,
        labelText: label ?? '',
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  suffixPressed;
                },
                icon: Icon(suffixIcon))
            : null,
        labelStyle: GoogleFonts.aBeeZee(),
      ),
      cursorColor: const Color(Style.kPrimaryColor),
    );
  }
}
