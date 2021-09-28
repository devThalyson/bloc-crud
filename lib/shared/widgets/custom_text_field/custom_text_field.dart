import 'package:bloc_crud/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelTitle;
  final TextEditingController controller;

  final int? maxLines;
  final TextInputAction? inputAction;

  final String? Function(String?)? validator;

  final void Function(String value) onChanged;

  CustomTextField({
    required this.labelTitle,
    required this.controller,
    this.maxLines = 1,
    this.inputAction,
    this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 30,
        right: 30,
        bottom: 15,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelTitle,
          labelStyle: AppTextStyles.titlePost,
        ),
        style: AppTextStyles.titlePost,
        textInputAction: inputAction,
        maxLines: maxLines,
      ),
    );
  }
}
