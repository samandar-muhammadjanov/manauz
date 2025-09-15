import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF0D6EFD);
  static const Color primaryLight = Color(0xFFE5F0FF);
  static const Color primaryDark = Color(0xFF0B5ED7);
  
  // Background colors
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF8F9FA);
  static const Color card = Colors.white;
  
  // Text colors
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textTertiary = Color(0xFFADB5BD);
  
  // Status colors
  static const Color success = Color(0xFF198754);
  static const Color error = Color(0xFFDC3545);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF0DCAF0);
  
  // Other
  static const Color border = Color(0xFFDEE2E6);
  static const Color shadow = Color(0x1A000000);
  static const Color shimmerBase = Color(0xFFE9ECEF);
  static const Color shimmerHighlight = Color(0xFFF8F9FA);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0D6EFD), Color(0xFF0DCAF0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x0F000000),
    blurRadius: 10,
    offset: Offset(0, 4),
    spreadRadius: 0,
  );
}
