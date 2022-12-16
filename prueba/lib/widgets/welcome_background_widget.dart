import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.60,
      decoration: const BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.vertical(
              top: Radius.zero, bottom: Radius.circular(100))),
    );
  }
}