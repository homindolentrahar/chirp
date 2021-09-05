import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final Widget? prefixIcon;
  final String hintText;
  final double textSize;
  final bool enabled;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction action;
  final String? Function(String?)? validators;
  final ValueChanged<String?>? onChanged;

  const AppTextField({
    Key? key,
    required this.controller,
    required this.name,
    this.prefixIcon,
    required this.hintText,
    this.textSize = 14,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.action = TextInputAction.done,
    required this.validators,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: action,
      name: name,
      style: Get.textTheme.subtitle2?.copyWith(color: AppColor.white),
      validator: validators,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.5),
          borderSide: BorderSide(color: AppColor.white.withOpacity(0.3)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.5),
          borderSide: BorderSide(color: Colors.redAccent.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.5),
          borderSide: BorderSide(color: AppColor.white, width: 1.3),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.5),
          borderSide: BorderSide(color: Colors.redAccent, width: 1.3),
        ),
        hintText: hintText,
        hintStyle: Get.textTheme.subtitle2?.copyWith(
          color: AppColor.white.withOpacity(0.45),
          fontWeight: FontWeight.normal,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
