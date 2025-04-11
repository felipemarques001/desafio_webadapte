import 'package:desafio_webadapte/src/ui/core/themes/app_colors.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTextStyles {
  static final headlineLarge = GoogleFonts.inter(
    fontWeight: FontWeight.w900,
    letterSpacing: -1.43,
    color: AppColors.white,
  );

  static final headlineMedium = GoogleFonts.inter(
    height: 1.6,
    letterSpacing: -0.47,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
  );

  static final headlineSmall = GoogleFonts.inter(
    letterSpacing: -0.18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static final strongHeadlineSmall = GoogleFonts.inter(
    fontWeight: FontWeight.w900,
    height: 1.6,
    letterSpacing: -0.69,
    color: AppColors.white,
  );

  static final bodyLarge = GoogleFonts.inter(
    height: 1.6,
    letterSpacing: -0.18,
    fontWeight: FontWeight.w400,
    color: AppColors.zinc400,
  );

  static final strongBodyLarge = GoogleFonts.inter(
    height: 1.6,
    letterSpacing: -0.18,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static final bodyMedium = GoogleFonts.inter(
    letterSpacing: -0.18,
    fontWeight: FontWeight.w400,
    color: AppColors.zinc300,
  );

  static final strongBodyMedium = GoogleFonts.inter(
    letterSpacing: -0.18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  ); 
}

abstract final class PhoneTextStyles {
  static final headlineMedium = AppTextStyles.headlineMedium.copyWith(
    fontSize: 24,
  );

  static final headlineSmall = AppTextStyles.headlineSmall.copyWith(
    fontSize: 16,
  );

  static final bodyLarge = AppTextStyles.bodyLarge.copyWith(
    fontSize: 16,
  );

  static final strongBodyLarge = AppTextStyles.strongBodyLarge.copyWith(
    fontSize: 16,
  );

  static final bodyMedium = AppTextStyles.bodyMedium.copyWith(
    fontSize: 14,
  );

  static final strongBodyMedium = AppTextStyles.strongBodyMedium.copyWith(
    fontSize: 14,
  );
}

abstract final class TabletTextStyles {
  static final headlineLarge = AppTextStyles.headlineLarge.copyWith(
    fontSize: 64,
  );

  static final headlineMedium = AppTextStyles.headlineMedium.copyWith(
    fontSize: 48,
  );

  static final headlineSmall = AppTextStyles.headlineSmall.copyWith(
    fontSize: 16,
  );

  static final strongHeadlineSmall = AppTextStyles.strongHeadlineSmall.copyWith(
    fontSize: 32,
  );

  static final bodyMedium = AppTextStyles.bodyMedium.copyWith(
    fontSize: 20,
  );

  static final strongBodyMedium = AppTextStyles.strongBodyMedium.copyWith(
    fontSize: 20,
  );

  static final strongBodySmall = AppTextStyles.strongBodyLarge.copyWith(
    fontSize: 16,
  );
}
