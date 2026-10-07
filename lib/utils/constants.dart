/// Constantes globales de espaciado, radios y breakpoints.
///
/// Decisión: archivo Dart puro (sin import de Flutter) para que los
/// valores sean utilizables en tests y no acoplen el modelo al framework.
/// Los [EdgeInsets] se construyen en los widgets a partir de estos doubles.
library;

// --- Espaciado base 8pt ---
/// Unidad base. Todo padding/margin deriva de múltiplos de 8.
const double kSpace4 = 4.0;
const double kSpace8 = 8.0;
const double kSpace12 = 12.0;
const double kSpace16 = 16.0;
const double kSpace20 = 20.0;
const double kSpace24 = 24.0;
const double kSpace32 = 32.0;

/// Padding lateral estándar en móvil.
const double kPaddingMobile = 16.0;

/// Padding lateral en tablet (600-899).
const double kPaddingTablet = 20.0;

/// Padding lateral en desktop (>=900).
const double kPaddingDesktop = 24.0;

// --- Radios ---
const double kRadiusCard = 16.0;
const double kRadiusChip = 20.0;
const double kRadiusBadge = 8.0;
const double kRadiusHero = 20.0;

// --- Tamaños ---
/// Altura del hero en móvil (Stack superpuesto).
const double kHeroHeightMobile = 280.0;

/// Altura del hero intermedio (600-899).
const double kHeroHeightTablet = 320.0;

/// Altura del hero desktop (Row dividido).
const double kHeroHeightDesktop = 320.0;

/// Tamaño de imagen cuadrada en ExperienceCard.
const double kExperienceImageSize = 112.0;

/// Área táctil mínima exigida por la rúbrica (48x48 dp).
const double kMinTouchTarget = 48.0;

// --- Breakpoints (justificados por ancho mínimo legible de card ~273px) ---
/// < 600 : 1 columna.
const double kBreakpointMobileMax = 600.0;

/// 600 - 899 : 2 columnas.
const double kBreakpointTabletMax = 899.0;

/// >= 900 : 3 columnas. Ver informe Sec 4.1 para el cálculo.
const double kBreakpointDesktopMin = 900.0;

/// Ancho máximo del contenido centrado en desktop.
const double kMaxContentWidth = 1100.0;

// --- Textos ---
/// Máximo de líneas permitido por tipo de texto (para ellipsis).
const int kMaxLinesCardTitle = 1;
const int kMaxLinesCardDesc = 2;
const int kMaxLinesHeroTitleMobile = 2;
const int kMaxLinesHeroDescMobile = 2;
const int kMaxLinesHeroDescDesktop = 3;
