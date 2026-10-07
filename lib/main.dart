import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'utils/app_theme.dart';

/// Punto de entrada. Composición con `HomeScreen`.
void main() {
  runApp(const SaboresDelCuscoApp());
}

class SaboresDelCuscoApp extends StatelessWidget {
  const SaboresDelCuscoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sabores del Cusco',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}
