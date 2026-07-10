import 'package:flutter/material.dart';

// ── Tile Colors ──
const BoxColors = <int, Color>{
  2: Color(0xffEEEEEE),
  4: Color(0xffB6B6B6),
  8: Color(0xffAAFFA2),
  16: Color(0xff46EB36),
  32: Color(0xff85BCF9),
  64: Color(0xff2D88EC),
  128: Color(0xffCA7EF9),
  256: Color(0xff9800F7),
  512: Color(0xffFAD17A),
  1024: Color(0xffF9B222),
};

Color tileColor(int number) =>
    BoxColors.containsKey(number) ? BoxColors[number]! : BoxColors[BoxColors.keys.last]!;

Color tileTextColor(int number) {
  return Colors.black.withValues(alpha: 0.8);
}

double tileFontSize(int number, double animationValue) {
  final base = number < 16 ? 40 : number < 128 ? 36 : number < 1024 ? 32 : 28;
  return base * animationValue;
}

// ── Palette ──
class AppColors {
  AppColors._();

  static const background = Color(0xff47507C);
  static const boardBorder = Color(0xff34415F);
  static const boardBackground = Color(0xff4C5B7D);
  static const primaryDark = Color(0xff373C69);
  static const accent = Color(0xffFF9C76);
  static const emptyTile = Color(0x1AFFFFFF);
  static const darkOverlay = Color(0x80000000);

  static const white = Colors.white;
  static const white70 = Color(0xB3FFFFFF);
  static const white50 = Color(0x80FFFFFF);
  static const white10 = Color(0x1AFFFFFF);
  static const black80 = Color(0xCC000000);
  static const black50 = Color(0x80000000);
}

// ── Typography ──
class AppTextStyles {
  AppTextStyles._();

  static const gameTitle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const modeSubtitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const description = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static const scoreLabel = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static const scoreValue = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const levelButton = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const actionButton = TextStyle(
    fontSize: 15,
    color: AppColors.accent,
  );

  static const pauseButton = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const gameOverToast = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
}

// ── Spacing ──
class AppInsets {
  AppInsets._();

  static const sym20 = EdgeInsets.symmetric(horizontal: 20);
  static const lr20 = EdgeInsets.fromLTRB(20, 0, 20, 0);
  static const scoreRow = EdgeInsets.fromLTRB(20, 10, 20, 0);
  static const adContainer = EdgeInsets.fromLTRB(20, 0, 20, 0);
  static const adContainerGame = EdgeInsets.fromLTRB(20, 0, 20, 20);
  static const cellH5 = EdgeInsets.symmetric(horizontal: 5);
}

// ── Border Radius ──
class AppRadii {
  AppRadii._();

  static const board = BorderRadius.all(Radius.circular(20));
  static const tile = BorderRadius.all(Radius.circular(8));
  static const levelButton = BorderRadius.all(Radius.circular(20));
  static const pauseButton = BorderRadius.all(Radius.circular(30));
}

// ── Board Config ──
class BoardConfig {
  BoardConfig._();

  static const double boardBorderWidth = 10;

  static double cellPadding(int row) =>
      row == 4 ? 15 : row == 5 ? 10 : 8;

  static double shadowOffset(int row) =>
      row == 4 ? 2 : row == 5 ? 1.5 : 1;
}
