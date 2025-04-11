import 'package:desafio_webadapte/src/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double opacity;

  const CustomCircularProgressIndicator({super.key, this.opacity = 0.2});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black.withValues(alpha: opacity),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.zinc300,
        ),
      ),
    );
  }
}