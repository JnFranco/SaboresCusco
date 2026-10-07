import 'package:flutter/material.dart';

/// Paleta "cusqueña moderna": cálida sin saturar.
///
/// Decisiones (para informe Sec 3.2 / 4.3):
/// - Fondo crema marfil, no blanco puro, para calidez gastronómica.
/// - Terracota como primario, oliva como secundario, dorado SOLO para
///   rating (uso no decorativo: siempre acompañado de número).
/// - Hero desktop usa [terracottaDark] como fondo sólido para garantizar
///   contraste >= 4.5:1 sin depender de overlay sobre imagen.
abstract final class AppColors {
  static const Color background = Color(0xFFFAF6EF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF2D1A12);
  static const Color inkSecondary = Color(0xFF7A6A5E);
  static const Color terracotta = Color(0xFFB94A2B);
  static const Color terracottaDark = Color(0xFF7A2E1D);
  static const Color olive = Color(0xFF6B7B3A);
  static const Color gold = Color(0xFFC9A227);
  static const Color outline = Color(0xFFE8DFD2);
}

/// Tema único claro. Sin ThemeMode oscuro: fuera de alcance UI estática.
abstract final class AppTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.terracotta,
      onPrimary: Colors.white,
      secondary: AppColors.olive,
      onSecondary: Colors.white,
      tertiary: AppColors.gold,
      surface: AppColors.surface,
      onSurface: AppColors.ink,
      surfaceContainerHighest: AppColors.background,
      error: Color(0xFFB3261E),
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(
        // Hero desktop (P4: portada debe escalar en pantalla grande)
        displaySmall: TextStyle(
          fontSize: 30,
          height: 1.15,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
        ),
        // Título de la app (P1: identidad por encima del contenido)
        headlineMedium: TextStyle(
          fontSize: 20,
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        // Hero
        headlineSmall: TextStyle(
          fontSize: 26,
          height: 1.2,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
        ),
        // Título de sección
        titleLarge: TextStyle(
          fontSize: 18,
          height: 1.3,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
        ),
        // Nombre de plato
        titleMedium: TextStyle(
          fontSize: 16,
          height: 1.3,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
        // Descripción
        bodyMedium: TextStyle(
          fontSize: 13,
          height: 1.45,
          color: AppColors.inkSecondary,
        ),
        // Caption / ubicación
        bodySmall: TextStyle(
          fontSize: 12,
          height: 1.4,
          color: AppColors.inkSecondary,
        ),
        // Badge
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: Colors.white,
        ),
        // Chip de categoría (P6: tipografía centralizada en el tema)
        labelLarge: TextStyle(
          fontSize: 13,
          height: 1.3,
          color: AppColors.ink,
        ),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.terracotta,
        labelStyle: TextStyle(fontSize: 13, color: AppColors.ink),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
