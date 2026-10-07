import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/dish.dart';
import '../models/experience.dart';

/// Datos ESTÁTICOS. Todo `const` para demostrar Null Safety e inmutabilidad.
///
/// Criterios de los textos (para probar layout en Paso 2+):
/// - Nombres: 1 corto ("Chairo"), 1 medio, 1 largo de 45 caracteres.
/// - Descripciones: 1 de 1 línea, varias de 2 líneas, 1 de 3 líneas.
/// - Ubicaciones: 1 corta, 1 larga (para ellipsis en Row de 273px).
abstract final class GastronomyData {
  // --- Hero editorial (Pachamanca) ---
  static const String heroTitle = 'Pachamanca a la tierra cusqueña';
  static const String heroDescription =
      'Cocción ancestral bajo piedras calientes con carnes, habas y papas '
      'nativas. La experiencia colectiva más emblemática del Valle Sagrado.';
  static const String heroImage = 'assets/images/pachamanca.jpg';
  static const String heroImageSemantic =
      'Pachamanca servida en olla de barro con papas andinas y habas';
  static const double heroRating = 4.9;
  static const String heroLocation = 'Valle Sagrado, Cusco';

  // --- 8 categorías: a propósito 8 para que Wrap haga 3 líneas en 360px ---
  static const List<Category> categories = <Category>[
    Category(label: 'Platos', icon: Icons.restaurant, isSelected: true),
    Category(label: 'Bebidas', icon: Icons.local_drink),
    Category(label: 'Postres', icon: Icons.cake),
    Category(label: 'Sopas', icon: Icons.soup_kitchen),
    Category(label: 'Mercados', icon: Icons.storefront),
    Category(label: 'Picanterías', icon: Icons.dinner_dining),
    Category(label: 'Festividades', icon: Icons.festival),
    Category(label: 'Experiencias', icon: Icons.map),
  ];

  // --- 6 platos ---
  static const List<Dish> dishes = <Dish>[
    Dish(
      name: 'Chiri Uchu',
      description: 'Plato frío festivo con cuy, gallina, maíz y rocoto.',
      imagePath: 'assets/images/chiri_uchu.jpg',
      imageSemanticLabel:
          'Plato de chiri uchu con cuy al horno, torreja de maíz y cochayuyo',
      category: 'Platos',
      rating: 4.8,
      location: 'San Blas, Cusco',
      isFeatured: true,
    ),
    Dish(
      name: 'Cuy al horno con relleno andino de hierbas',
      // Nombre largo (~45 caracteres) para probar maxLines:1 + ellipsis
      // en cards de 273px (breakpoint >=900).
      description:
          'Cuy crocante al horno de leña acompañado de papas doradas, '
          'ensalada criolla y crema de huacatay de la casa.',
      imagePath: 'assets/images/cuy_horno.jpg',
      imageSemanticLabel: 'Cuy entero al horno con papas doradas',
      category: 'Platos',
      rating: 4.9,
      location: 'Picantería La Chomba, San Sebastián',
      isFeatured: true,
    ),
    Dish(
      name: 'Adobo cusqueño',
      description: 'Caldo concentrado de cerdo macerado en chicha.',
      imagePath: 'assets/images/adobo_cusqueno.jpg',
      imageSemanticLabel: 'Plato de adobo de cerdo con caldo',
      category: 'Sopas',
      rating: 4.7,
      location: 'Santiago, Cusco',
    ),
    Dish(
      name: 'Chairo',
      description:
          'Sopa robusta de chuño, trigo, habas y carne de cordero, '
          'heredada de la cocina altoandina y servida bien caliente.',
      imagePath: 'assets/images/chairo.jpg',
      imageSemanticLabel: 'Plato hondo de chairo con chuño y trigo',
      category: 'Sopas',
      rating: 4.6,
      location: 'Mercado San Pedro',
    ),
    Dish(
      name: 'Kapchi de habas',
      description:
          'Guiso cremoso de habas frescas con queso cusqueño y huacatay.',
      imagePath: 'assets/images/kapchi.jpg',
      imageSemanticLabel: 'Guiso de habas tradicional servido en el Cusco',
      category: 'Platos',
      rating: 4.5,
      location: 'Urubamba',
    ),
    Dish(
      name: 'Chicha de jora',
      description: 'Bebida ancestral de maíz fermentado en chombas de barro.',
      imagePath: 'assets/images/chicha_jora.jpg',
      imageSemanticLabel: 'Vasos de chicha de jora espumosa',
      category: 'Bebidas',
      rating: 4.7,
      location: 'Chinchero, Valle Sagrado',
    ),
  ];

  // --- 3 experiencias (layout horizontal, distinto al grid) ---
  static const List<Experience> experiences = <Experience>[
    Experience(
      title: 'Mercado San Pedro',
      description:
          'Recorrido entre juguerías, quesos y panes chuta recién horneados.',
      imagePath: 'assets/images/mercado_san_pedro.jpg',
      imageSemanticLabel: 'Pasillo del mercado San Pedro con frutas',
      location: 'San Pedro, Cusco',
      duration: '2-3 h',
    ),
    Experience(
      title: 'Picantería tradicional cusqueña',
      description:
          'Chicha, cuy y música en locales de adobe con más de 50 años.',
      imagePath: 'assets/images/picanteria_la_chomba.jpg',
      imageSemanticLabel: 'Ingreso de la picantería La Chomba en el Cusco',
      location: 'San Sebastián',
      duration: 'Todo el día',
    ),
    Experience(
      title: 'Festividad del Chiri Uchu en Corpus',
      description:
          'Degustación colectiva del plato bandera durante el Corpus Christi.',
      imagePath: 'assets/images/experiencia_chiri_uchu.jpg',
      imageSemanticLabel: 'Procesión de Corpus Christi en la plaza del Cusco',
      location: 'Plaza de Armas',
      duration: 'Junio',
    ),
  ];

  /// Imágenes locales en assets/images/ (10 archivos, todos <300KB):
  /// pachamanca.jpg (1280x720 hero), chiri_uchu.jpg, cuy_horno.jpg,
  /// adobo_cusqueno.jpg, chairo.jpg, kapchi.jpg (800x450 platos),
  /// chicha_jora.jpg (800x450, cubre categoría Bebidas),
  /// mercado_san_pedro.jpg, picanteria_la_chomba.jpg,
  /// experiencia_chiri_uchu.jpg (600x600 experiencias).
  /// Nota: se mantiene chicha_jora.jpg en lugar de chicharron.jpg del
  /// ejemplo para conservar cobertura de la categoría Bebidas.
  static const List<String> requiredAssets = <String>[
    heroImage,
    'assets/images/chiri_uchu.jpg',
    'assets/images/cuy_horno.jpg',
    'assets/images/adobo_cusqueno.jpg',
    'assets/images/chairo.jpg',
    'assets/images/kapchi.jpg',
    'assets/images/chicha_jora.jpg',
    'assets/images/mercado_san_pedro.jpg',
    'assets/images/picanteria_la_chomba.jpg',
    'assets/images/experiencia_chiri_uchu.jpg',
  ];
}
