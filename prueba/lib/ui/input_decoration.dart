
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon,
      IconButton? suffix}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary),
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primary, width: 2)),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primary, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: suffix,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppTheme.primary)
            : null);
  }
}
