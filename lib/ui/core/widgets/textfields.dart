import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

enum AppTextFieldType { BORDER, UNDERLINE, NONE }

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool autofocus;
  final String name;
  final Widget? prefixIcon;
  final String? prefixText;
  final String hintText;
  final double textSize;
  final bool enabled;
  final bool obscureText;
  final int? maxLines;
  final TextInputType keyboardType;
  final TextInputAction action;
  final AppTextFieldType type;
  final String? Function(String?)? validators;
  final ValueChanged<String?>? onChanged;

  const AppTextField({
    Key? key,
    required this.controller,
    this.autofocus = false,
    required this.name,
    this.prefixIcon,
    this.prefixText,
    required this.hintText,
    this.textSize = 14,
    this.enabled = true,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.action = TextInputAction.done,
    this.type = AppTextFieldType.BORDER,
    required this.validators,
    required this.onChanged,
  }) : super(key: key);

  Map<AppTextFieldType, InputBorder> fieldType({
    Color color = Colors.grey,
    double width = 1,
  }) =>
      {
        AppTextFieldType.BORDER: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.5),
          borderSide: BorderSide(color: color, width: width),
        ),
        AppTextFieldType.UNDERLINE: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(2.5),
          borderSide: BorderSide(color: color, width: width),
        ),
        AppTextFieldType.NONE: InputBorder.none,
      };

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: action,
      maxLines: maxLines,
      name: name,
      style: Get.textTheme.subtitle2,
      validator: validators,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? prefixIcon
            : prefixText != null
                ? Text(
                    "${prefixText.toString()} ",
                    style: Get.textTheme.subtitle2?.copyWith(
                      color: AppColor.white.withOpacity(0.45),
                      fontWeight: FontWeight.normal,
                    ),
                  )
                : null,
        prefixIconConstraints: prefixText != null
            ? BoxConstraints(minWidth: 0, minHeight: 0)
            : null,
        enabledBorder: fieldType(color: AppColor.white.withOpacity(0.2))[type],
        errorBorder: fieldType(color: Colors.red, width: 1.5)[type],
        focusedBorder: fieldType(color: AppColor.white, width: 1.5)[type],
        focusedErrorBorder: fieldType(color: Colors.red, width: 1.5)[type],
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
