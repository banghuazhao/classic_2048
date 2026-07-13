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

  /// `Levels`
  String get Levels {
    return Intl.message('Levels', name: 'Levels', desc: '', args: []);
  }

  /// `Zen`
  String get Zen_Mode {
    return Intl.message('Zen', name: 'Zen_Mode', desc: '', args: []);
  }

  /// `An endless board that clears space when stuck`
  String get Zen_Subtitle {
    return Intl.message(
      'An endless board that clears space when stuck',
      name: 'Zen_Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Challenges`
  String get Challenges {
    return Intl.message('Challenges', name: 'Challenges', desc: '', args: []);
  }

  /// `Settings`
  String get Settings {
    return Intl.message('Settings', name: 'Settings', desc: '', args: []);
  }

  /// `Background music`
  String get Background_Music {
    return Intl.message(
      'Background music',
      name: 'Background_Music',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get Music_Off {
    return Intl.message('Off', name: 'Music_Off', desc: '', args: []);
  }

  /// `Quiet Forest`
  String get Music_Forest {
    return Intl.message(
      'Quiet Forest',
      name: 'Music_Forest',
      desc: '',
      args: [],
    );
  }

  /// `Meditation Bowl`
  String get Music_Meditation {
    return Intl.message(
      'Meditation Bowl',
      name: 'Music_Meditation',
      desc: '',
      args: [],
    );
  }

  /// `Minstrel Journey`
  String get Music_Medieval {
    return Intl.message(
      'Minstrel Journey',
      name: 'Music_Medieval',
      desc: '',
      args: [],
    );
  }

  /// `Sound effects`
  String get Sound_Effects {
    return Intl.message(
      'Sound effects',
      name: 'Sound_Effects',
      desc: '',
      args: [],
    );
  }

  /// `Easy`
  String get Easy {
    return Intl.message('Easy', name: 'Easy', desc: '', args: []);
  }

  /// `Medium`
  String get Medium {
    return Intl.message('Medium', name: 'Medium', desc: '', args: []);
  }

  /// `Hard`
  String get Hard {
    return Intl.message('Hard', name: 'Hard', desc: '', args: []);
  }

  /// `Golden`
  String get Golden {
    return Intl.message('Golden', name: 'Golden', desc: '', args: []);
  }

  /// `Level {number}`
  String Level_Number(Object number) {
    return Intl.message(
      'Level $number',
      name: 'Level_Number',
      desc: '',
      args: [number],
    );
  }

  /// `Locked`
  String get Locked {
    return Intl.message('Locked', name: 'Locked', desc: '', args: []);
  }

  /// `Completed`
  String get Completed {
    return Intl.message('Completed', name: 'Completed', desc: '', args: []);
  }

  /// `Goal`
  String get Goal {
    return Intl.message('Goal', name: 'Goal', desc: '', args: []);
  }

  /// `Play without limits`
  String get Objective_Endless {
    return Intl.message(
      'Play without limits',
      name: 'Objective_Endless',
      desc: '',
      args: [],
    );
  }

  /// `Reach {score} points`
  String Objective_Score(Object score) {
    return Intl.message(
      'Reach $score points',
      name: 'Objective_Score',
      desc: '',
      args: [score],
    );
  }

  /// `Create a {tile} tile`
  String Objective_Tile(Object tile) {
    return Intl.message(
      'Create a $tile tile',
      name: 'Objective_Tile',
      desc: '',
      args: [tile],
    );
  }

  /// `Play for {seconds} seconds`
  String Objective_Time(Object seconds) {
    return Intl.message(
      'Play for $seconds seconds',
      name: 'Objective_Time',
      desc: '',
      args: [seconds],
    );
  }

  /// `Score {score} in {seconds} seconds`
  String Objective_Timed_Score(Object score, Object seconds) {
    return Intl.message(
      'Score $score in $seconds seconds',
      name: 'Objective_Timed_Score',
      desc: '',
      args: [score, seconds],
    );
  }

  /// `Play {moves} moves`
  String Objective_Moves(Object moves) {
    return Intl.message(
      'Play $moves moves',
      name: 'Objective_Moves',
      desc: '',
      args: [moves],
    );
  }

  /// `Score {score} within {moves} moves`
  String Objective_Move_Score(Object score, Object moves) {
    return Intl.message(
      'Score $score within $moves moves',
      name: 'Objective_Move_Score',
      desc: '',
      args: [score, moves],
    );
  }

  /// `Merge the golden tile to {tile} or higher`
  String Objective_Golden(Object tile) {
    return Intl.message(
      'Merge the golden tile to $tile or higher',
      name: 'Objective_Golden',
      desc: '',
      args: [tile],
    );
  }

  /// `Score`
  String get Score_Goal {
    return Intl.message('Score', name: 'Score_Goal', desc: '', args: []);
  }

  /// `Tile`
  String get Tile_Goal {
    return Intl.message('Tile', name: 'Tile_Goal', desc: '', args: []);
  }

  /// `Speed`
  String get Speed_Goal {
    return Intl.message('Speed', name: 'Speed_Goal', desc: '', args: []);
  }

  /// `Moves`
  String get Move_Goal {
    return Intl.message('Moves', name: 'Move_Goal', desc: '', args: []);
  }

  /// `Golden tile`
  String get Golden_Goal {
    return Intl.message('Golden tile', name: 'Golden_Goal', desc: '', args: []);
  }

  /// `Level Complete`
  String get Level_Complete {
    return Intl.message(
      'Level Complete',
      name: 'Level_Complete',
      desc: '',
      args: [],
    );
  }

  /// `Challenge Complete`
  String get Challenge_Won {
    return Intl.message(
      'Challenge Complete',
      name: 'Challenge_Won',
      desc: '',
      args: [],
    );
  }

  /// `Challenge Failed`
  String get Challenge_Failed {
    return Intl.message(
      'Challenge Failed',
      name: 'Challenge_Failed',
      desc: '',
      args: [],
    );
  }

  /// `Tools`
  String get Tools {
    return Intl.message('Tools', name: 'Tools', desc: '', args: []);
  }

  /// `Double`
  String get Double_Tool {
    return Intl.message('Double', name: 'Double_Tool', desc: '', args: []);
  }

  /// `Hammer`
  String get Hammer_Tool {
    return Intl.message('Hammer', name: 'Hammer_Tool', desc: '', args: []);
  }

  /// `3×3 Bomb`
  String get Bomb_Tool {
    return Intl.message('3×3 Bomb', name: 'Bomb_Tool', desc: '', args: []);
  }

  /// `Select a tile to use {tool}`
  String Select_Tile(Object tool) {
    return Intl.message(
      'Select a tile to use $tool',
      name: 'Select_Tile',
      desc: '',
      args: [tool],
    );
  }

  /// `{count} left`
  String Uses_Left(Object count) {
    return Intl.message(
      '$count left',
      name: 'Uses_Left',
      desc: '',
      args: [count],
    );
  }

  /// `The glowing golden tile triples when merged. Build it to the marked target.`
  String get Golden_Help {
    return Intl.message(
      'The glowing golden tile triples when merged. Build it to the marked target.',
      name: 'Golden_Help',
      desc: '',
      args: [],
    );
  }

  /// `Zen cleared space so you can keep playing.`
  String get Zen_Revived {
    return Intl.message(
      'Zen cleared space so you can keep playing.',
      name: 'Zen_Revived',
      desc: '',
      args: [],
    );
  }

  /// `10 levels · easy to expert`
  String get All_Levels {
    return Intl.message(
      '10 levels · easy to expert',
      name: 'All_Levels',
      desc: '',
      args: [],
    );
  }

  /// `3 easy · 3 medium · 3 hard`
  String get Challenge_Count {
    return Intl.message(
      '3 easy · 3 medium · 3 hard',
      name: 'Challenge_Count',
      desc: '',
      args: [],
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
