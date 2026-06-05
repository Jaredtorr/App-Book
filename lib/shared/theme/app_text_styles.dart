import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.hint,
  );

  static const button = TextStyle(
    fontSize: 16,
    color: AppColors.background,
    fontWeight: FontWeight.bold,
  );

  static const error = TextStyle(
    fontSize: 14,
    color: AppColors.error,
  );
}