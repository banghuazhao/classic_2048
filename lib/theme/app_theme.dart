import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = _theme(Brightness.light);
  static ThemeData dark = _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xff5B5F97),
      brightness: brightness,
      primary: dark ? const Color(0xffC3C5FF) : const Color(0xff4E538E),
      secondary: dark ? const Color(0xffffb59c) : const Color(0xff9D452A),
      surface: dark ? const Color(0xff161724) : const Color(0xffF8F7FF),
    );
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: InkSparkle.splashFactory,
    );
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: base.textTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.w900,
          letterSpacing: -2,
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        labelLarge: base.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.control),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(minimumSize: const Size.square(48)),
      ),
      extensions: <ThemeExtension<dynamic>>[
        GameTheme(
          board: dark ? const Color(0xff303655) : const Color(0xff465174),
          boardBorder: dark ? const Color(0xff22263D) : const Color(0xff34415F),
          emptyTile: Colors.white.withValues(alpha: dark ? 0.08 : 0.12),
          accent: dark ? const Color(0xffffb59c) : const Color(0xffFF8F68),
          scrim: Colors.black.withValues(alpha: 0.72),
        ),
      ],
    );
  }
}

@immutable
class GameTheme extends ThemeExtension<GameTheme> {
  final Color board;
  final Color boardBorder;
  final Color emptyTile;
  final Color accent;
  final Color scrim;

  const GameTheme({
    required this.board,
    required this.boardBorder,
    required this.emptyTile,
    required this.accent,
    required this.scrim,
  });

  static GameTheme of(BuildContext context) =>
      Theme.of(context).extension<GameTheme>()!;

  @override
  GameTheme copyWith({
    Color? board,
    Color? boardBorder,
    Color? emptyTile,
    Color? accent,
    Color? scrim,
  }) =>
      GameTheme(
        board: board ?? this.board,
        boardBorder: boardBorder ?? this.boardBorder,
        emptyTile: emptyTile ?? this.emptyTile,
        accent: accent ?? this.accent,
        scrim: scrim ?? this.scrim,
      );

  @override
  GameTheme lerp(covariant GameTheme? other, double t) {
    if (other == null) return this;
    return GameTheme(
      board: Color.lerp(board, other.board, t)!,
      boardBorder: Color.lerp(boardBorder, other.boardBorder, t)!,
      emptyTile: Color.lerp(emptyTile, other.emptyTile, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
    );
  }
}

const tileColors = <int, Color>{
  2: Color(0xffF2F1EE),
  4: Color(0xffC9C8C2),
  8: Color(0xffB7E7A9),
  16: Color(0xff67D45A),
  32: Color(0xff9BC7F5),
  64: Color(0xff4B93DF),
  128: Color(0xffD39AF5),
  256: Color(0xffA74DDE),
  512: Color(0xffF6D590),
  1024: Color(0xffF4B943),
};

Color tileColor(int number) => tileColors[number] ?? tileColors[1024]!;
Color tileTextColor(int number) => Colors.black.withValues(alpha: 0.82);
TextStyle tileTextStyle(BuildContext context, int number) =>
    Theme.of(context).textTheme.displaySmall!.copyWith(
          fontSize: number < 16
              ? 40
              : number < 128
                  ? 36
                  : number < 1024
                      ? 32
                      : 28,
          fontWeight: FontWeight.w900,
          color: tileTextColor(number),
        );

class AppSpacing {
  AppSpacing._();
  static const double xxs = 4, xs = 8, sm = 12, md = 16, lg = 24, xl = 32;
}

class AppInsets {
  AppInsets._();
  static const scoreRow = EdgeInsets.fromLTRB(20, 10, 20, 0);
  static const adContainerGame = EdgeInsets.fromLTRB(20, 0, 20, 12);
  static const cellH5 = EdgeInsets.symmetric(horizontal: 5);
}

class AppRadii {
  AppRadii._();
  static const double control = 18;
  static const board = BorderRadius.all(Radius.circular(24));
  static const tile = BorderRadius.all(Radius.circular(10));
}

class BoardConfig {
  BoardConfig._();
  static const double borderWidth = 10;
  static double cellPadding(int row) => row == 4
      ? 14
      : row == 5
          ? 10
          : 8;
  static double shadowOffset(int row) => row == 4
      ? 2
      : row == 5
          ? 1.5
          : 1;
}
