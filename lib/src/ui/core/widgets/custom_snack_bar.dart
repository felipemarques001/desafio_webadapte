import 'package:desafio_webadapte/src/ui/core/themes/app_colors.dart';
import 'package:desafio_webadapte/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  final bool isError;
  final String message;
  final BuildContext context;

  const CustomSnackBar({
    required this.isError,
    required this.message,
    required this.context,
  });

  void showSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TabletTextStyles.strongBodyMedium,
      ),
      backgroundColor: (isError) ? AppColors.red400 : AppColors.emerald400,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
