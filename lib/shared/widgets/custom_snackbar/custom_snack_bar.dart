import 'package:bloc_crud/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String textContent;
  final bool isErrorSnackbar;

  CustomSnackBar({
    required this.textContent,
    this.isErrorSnackbar = false,
  }) : super(
          duration: Duration(
            seconds: 3,
          ),
          backgroundColor:
              isErrorSnackbar ? Colors.red[900] : Colors.green[900],
          content: Text(
            textContent,
            style: AppTextStyles.snackbarMessage,
          ),
        );
}
