// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Score`
  String get Score {
    return Intl.message('Score', name: 'Score', desc: '', args: []);
  }

  /// `High Score`
  String get High_Score {
    return Intl.message('High Score', name: 'High_Score', desc: '', args: []);
  }

  /// `Game Over`
  String get Game_Over {
    return Intl.message('Game Over', name: 'Game_Over', desc: '', args: []);
  }

  /// `Random`
  String get Random {
    return Intl.message('Random', name: 'Random', desc: '', args: []);
  }

  /// `Shuffle`
  String get Shuffle {
    return Intl.message('Shuffle', name: 'Shuffle', desc: '', args: []);
  }

  /// `Restart`
  String get Restart {
    return Intl.message('Restart', name: 'Restart', desc: '', args: []);
  }

  /// `Continue`
  String get Continue {
    return Intl.message('Continue', name: 'Continue', desc: '', args: []);
  }

  /// `No more moves! Start a new game?`
  String get Game_Over_Message {
    return Intl.message(
      'No more moves! Start a new game?',
      name: 'Game_Over_Message',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get Back {
    return Intl.message('Back', name: 'Back', desc: '', args: []);
  }

  /// `Tile {value}`
  String Board_Cell(Object value) {
    return Intl.message(
      'Tile $value',
      name: 'Board_Cell',
      desc: '',
      args: [value],
    );
  }

  /// `Tile Trials`
  String get App_Name {
    return Intl.message('Tile Trials', name: 'App_Name', desc: '', args: []);
  }

  /// `Choose your challenge`
  String get Choose_Mode {
    return Intl.message(
      'Choose your challenge',
      name: 'Choose_Mode',
      desc: '',
      args: [],
    );
  }

  /// `Daily puzzles, score sprints, and move-limited strategy.`
  String get Home_Description {
    return Intl.message(
      'Daily puzzles, score sprints, and move-limited strategy.',
      name: 'Home_Description',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get Today {
    return Intl.message('Today', name: 'Today', desc: '', args: []);
  }

  /// `Challenge modes`
  String get Challenge_Modes {
    return Intl.message(
      'Challenge modes',
      name: 'Challenge_Modes',
      desc: '',
      args: [],
    );
  }

  /// `Classic boards`
  String get Classic_Boards {
    return Intl.message(
      'Classic boards',
      name: 'Classic_Boards',
      desc: '',
      args: [],
    );
  }

  /// `Daily Challenge`
  String get Daily_Challenge {
    return Intl.message(
      'Daily Challenge',
      name: 'Daily_Challenge',
      desc: '',
      args: [],
    );
  }

  /// `Same 100-move puzzle for everyone`
  String get Daily_Subtitle {
    return Intl.message(
      'Same 100-move puzzle for everyone',
      name: 'Daily_Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Sprint`
  String get Sprint {
    return Intl.message('Sprint', name: 'Sprint', desc: '', args: []);
  }

  /// `3 minute score race`
  String get Sprint_Subtitle {
    return Intl.message(
      '3 minute score race',
      name: 'Sprint_Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Move Challenge`
  String get Move_Challenge {
    return Intl.message(
      'Move Challenge',
      name: 'Move_Challenge',
      desc: '',
      args: [],
    );
  }

  /// `Highest score in 100 moves`
  String get Move_Subtitle {
    return Intl.message(
      'Highest score in 100 moves',
      name: 'Move_Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Progress & achievements`
  String get Progress_Achievements {
    return Intl.message(
      'Progress & achievements',
      name: 'Progress_Achievements',
      desc: '',
      args: [],
    );
  }

  /// `Your progress`
  String get Your_Progress {
    return Intl.message(
      'Your progress',
      name: 'Your_Progress',
      desc: '',
      args: [],
    );
  }

  /// `Achievements`
  String get Achievements {
    return Intl.message(
      'Achievements',
      name: 'Achievements',
      desc: '',
      args: [],
    );
  }

  /// `Complete challenges to unlock achievements.`
  String get No_Achievements {
    return Intl.message(
      'Complete challenges to unlock achievements.',
      name: 'No_Achievements',
      desc: '',
      args: [],
    );
  }

  /// `{games} games · {moves} moves`
  String Games_Moves(Object games, Object moves) {
    return Intl.message(
      '$games games · $moves moves',
      name: 'Games_Moves',
      desc: '',
      args: [games, moves],
    );
  }

  /// `Best score {score} · Highest tile {tile}`
  String Best_Highest(Object score, Object tile) {
    return Intl.message(
      'Best score $score · Highest tile $tile',
      name: 'Best_Highest',
      desc: '',
      args: [score, tile],
    );
  }

  /// `Moves`
  String get Moves {
    return Intl.message('Moves', name: 'Moves', desc: '', args: []);
  }

  /// `Time`
  String get Time {
    return Intl.message('Time', name: 'Time', desc: '', args: []);
  }

  /// `Time!`
  String get Time_Up {
    return Intl.message('Time!', name: 'Time_Up', desc: '', args: []);
  }

  /// `Challenge Complete`
  String get Challenge_Complete {
    return Intl.message(
      'Challenge Complete',
      name: 'Challenge_Complete',
      desc: '',
      args: [],
    );
  }

  /// `{moves} moves · Highest tile {tile}`
  String Highest_Tile_Result(Object moves, Object tile) {
    return Intl.message(
      '$moves moves · Highest tile $tile',
      name: 'Highest_Tile_Result',
      desc: '',
      args: [moves, tile],
    );
  }

  /// `Share result`
  String get Share_Result {
    return Intl.message(
      'Share result',
      name: 'Share_Result',
      desc: '',
      args: [],
    );
  }

  /// `Paused`
  String get Paused {
    return Intl.message('Paused', name: 'Paused', desc: '', args: []);
  }

  /// `Your board is waiting.`
  String get Board_Waiting {
    return Intl.message(
      'Your board is waiting.',
      name: 'Board_Waiting',
      desc: '',
      args: [],
    );
  }

  /// `A fresh trial every day`
  String get Onboarding_Title_1 {
    return Intl.message(
      'A fresh trial every day',
      name: 'Onboarding_Title_1',
      desc: '',
      args: [],
    );
  }

  /// `Play the same seeded 100-move puzzle as everyone else.`
  String get Onboarding_Body_1 {
    return Intl.message(
      'Play the same seeded 100-move puzzle as everyone else.',
      name: 'Onboarding_Body_1',
      desc: '',
      args: [],
    );
  }

  /// `Race or plan`
  String get Onboarding_Title_2 {
    return Intl.message(
      'Race or plan',
      name: 'Onboarding_Title_2',
      desc: '',
      args: [],
    );
  }

  /// `Sprint for three minutes or build the best board in 100 moves.`
  String get Onboarding_Body_2 {
    return Intl.message(
      'Sprint for three minutes or build the best board in 100 moves.',
      name: 'Onboarding_Body_2',
      desc: '',
      args: [],
    );
  }

  /// `Build your record`
  String get Onboarding_Title_3 {
    return Intl.message(
      'Build your record',
      name: 'Onboarding_Title_3',
      desc: '',
      args: [],
    );
  }

  /// `Grow a daily streak, unlock achievements, and climb Game Center.`
  String get Onboarding_Body_3 {
    return Intl.message(
      'Grow a daily streak, unlock achievements, and climb Game Center.',
      name: 'Onboarding_Body_3',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message('Next', name: 'Next', desc: '', args: []);
  }

  /// `Start playing`
  String get Start_Playing {
    return Intl.message(
      'Start playing',
      name: 'Start_Playing',
      desc: '',
      args: [],
    );
  }

  /// `Daily streak`
  String get Daily_Streak {
    return Intl.message(
      'Daily streak',
      name: 'Daily_Streak',
      desc: '',
      args: [],
    );
  }

  /// `{days}-day streak`
  String Day_Streak(Object days) {
    return Intl.message(
      '$days-day streak',
      name: 'Day_Streak',
      desc: '',
      args: [days],
    );
  }

  /// `Daily history`
  String get Daily_History {
    return Intl.message(
      'Daily history',
      name: 'Daily_History',
      desc: '',
      args: [],
    );
  }

  /// `Complete today's challenge to begin your streak.`
  String get No_Daily_History {
    return Intl.message(
      'Complete today\'s challenge to begin your streak.',
      name: 'No_Daily_History',
      desc: '',
      args: [],
    );
  }

  /// `Game Center`
  String get Game_Center {
    return Intl.message('Game Center', name: 'Game_Center', desc: '', args: []);
  }

  /// `Leaderboards`
  String get Leaderboards {
    return Intl.message(
      'Leaderboards',
      name: 'Leaderboards',
      desc: '',
      args: [],
    );
  }

  /// `Classic`
  String get Classic {
    return Intl.message('Classic', name: 'Classic', desc: '', args: []);
  }

  /// `Endless strategy`
  String get Classic_Endless {
    return Intl.message(
      'Endless strategy',
      name: 'Classic_Endless',
      desc: '',
      args: [],
    );
  }

  /// `Classic · one new tile`
  String get Mode_4_1 {
    return Intl.message(
      'Classic · one new tile',
      name: 'Mode_4_1',
      desc: '',
      args: [],
    );
  }

  /// `More room · relaxed pace`
  String get Mode_5_1 {
    return Intl.message(
      'More room · relaxed pace',
      name: 'Mode_5_1',
      desc: '',
      args: [],
    );
  }

  /// `More room · faster challenge`
  String get Mode_5_2 {
    return Intl.message(
      'More room · faster challenge',
      name: 'Mode_5_2',
      desc: '',
      args: [],
    );
  }

  /// `Large board · strategic`
  String get Mode_6_2 {
    return Intl.message(
      'Large board · strategic',
      name: 'Mode_6_2',
      desc: '',
      args: [],
    );
  }

  /// `Large board · expert`
  String get Mode_6_3 {
    return Intl.message(
      'Large board · expert',
      name: 'Mode_6_3',
      desc: '',
      args: [],
    );
  }

  /// `2048 Master`
  String get Achievement_2048 {
    return Intl.message(
      '2048 Master',
      name: 'Achievement_2048',
      desc: '',
      args: [],
    );
  }

  /// `10K Club`
  String get Achievement_10K {
    return Intl.message(
      '10K Club',
      name: 'Achievement_10K',
      desc: '',
      args: [],
    );
  }

  /// `Efficient Thinker`
  String get Achievement_Efficient {
    return Intl.message(
      'Efficient Thinker',
      name: 'Achievement_Efficient',
      desc: '',
      args: [],
    );
  }

  /// `Seven Day Streak`
  String get Achievement_Streak {
    return Intl.message(
      'Seven Day Streak',
      name: 'Achievement_Streak',
      desc: '',
      args: [],
    );
  }

  /// `I scored {score} in {mode} with {moves} moves and reached {tile}.`
  String Share_Message(Object score, Object mode, Object moves, Object tile) {
    return Intl.message(
      'I scored $score in $mode with $moves moves and reached $tile.',
      name: 'Share_Message',
      desc: '',
      args: [score, mode, moves, tile],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
