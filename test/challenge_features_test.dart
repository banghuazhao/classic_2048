import 'package:classic_2048/challenge.dart';
import 'package:classic_2048/logic.dart';
import 'package:classic_2048/progress_store.dart';
import 'package:classic_2048/onboarding.dart';
import 'package:classic_2048/generated/l10n.dart';
import 'package:classic_2048/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('daily challenge is stable for the same calendar day', () {
    final morning = ChallengeConfig.daily(DateTime(2026, 7, 12, 8));
    final evening = ChallengeConfig.daily(DateTime(2026, 7, 12, 20));
    expect(morning.id, evening.id);
    expect(morning.seed, evening.seed);
  });

  test('catalog includes ten levels and three challenges per difficulty', () {
    expect(ChallengeConfig.levels, hasLength(10));
    expect(ChallengeConfig.challenges, hasLength(9));
    for (final difficulty in ChallengeDifficulty.values) {
      expect(
          ChallengeConfig.challenges
              .where((challenge) => challenge.difficulty == difficulty),
          hasLength(3));
    }
    expect(
        ChallengeConfig.levels.where((level) => level.hasGolden), hasLength(3));
  });

  test('golden tile triples and tracks its merged value', () {
    final game = Game(4, 4, 1, goldenEnabled: true)..init();
    game.restore({
      'score': 0,
      'goldenHighest': 0,
      'board': List.generate(
          4,
          (r) => List.generate(
              4,
              (c) => {
                    'number': r == 0 && c < 2 ? 2 : 0,
                    'golden': r == 0 && c == 0,
                  })),
    });
    expect(game.moveLeft(), isTrue);
    expect(game.get(0, 0).number, 6);
    expect(game.get(0, 0).isGolden, isTrue);
    expect(game.goldenHighest, 6);
  });

  test('double, hammer, and bomb tools mutate the selected area', () {
    final game = Game(4, 4, 1)..init();
    game.restore({
      'score': 0,
      'board': List.generate(
          4,
          (r) => List.generate(
              4,
              (c) => {
                    'number': r < 2 && c < 2 ? 2 : 0,
                    'golden': false,
                  })),
    });
    expect(game.doubleCell(0, 0), isTrue);
    expect(game.get(0, 0).number, 4);
    expect(game.hammerCell(0, 1), isTrue);
    expect(game.get(0, 1).number, 0);
    expect(game.bombCell(1, 1), isTrue);
    expect(game.get(1, 1).number, 8);
  });

  test('seeded games produce the same board sequence', () {
    final first = Game(4, 4, 1, seed: 42)..init();
    final second = Game(4, 4, 1, seed: 42)..init();
    expect(first.toJson()['board'], second.toJson()['board']);
    first.moveLeft();
    second.moveLeft();
    expect(first.toJson()['board'], second.toJson()['board']);
  });

  test('board snapshot restores score and tiles', () {
    final original = Game(4, 4, 1, seed: 7)..init();
    original.moveDown();
    final snapshot = original.toJson();
    final restored = Game(4, 4, 1)..init();
    restored.restore(snapshot);
    expect(restored.toJson()['board'], snapshot['board']);
    expect(restored.score, snapshot['score']);
  });

  test('progress store retains records and achievements', () async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressStore();
    await store.record(
        mode: 'test', score: 12000, moves: 80, highestTile: 2048, seconds: 90);
    final stats = await store.stats();
    expect(stats['games'], 1);
    expect(stats['bestScore'], 12000);
    expect(stats['achievement2048'], isTrue);
    expect(stats['achievement10k'], isTrue);
    expect(stats['achievementEfficient'], isTrue);
  });

  test('completed level persists unlock progress', () async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressStore();
    await store.record(
        mode: 'level-3',
        score: 1200,
        moves: 60,
        highestTile: 128,
        seconds: 90,
        completed: true,
        level: 3);
    final stats = await store.stats();
    expect(stats['highestLevel'], 3);
    expect(stats['completedModes'], contains('level-3'));
  });

  test('daily completion records history and streak', () async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressStore();
    await store.record(
        mode: 'daily-today',
        score: 100,
        moves: 100,
        highestTile: 64,
        seconds: 60);
    final stats = await store.stats();
    expect(stats['dailyHistory'], hasLength(1));
    expect(stats['dailyStreak'], 1);
  });

  testWidgets('localized onboarding completes and persists', (tester) async {
    SharedPreferences.setMockInitialValues({});
    var completed = false;
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('zh'),
      theme: AppTheme.light,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: OnboardingPage(onComplete: () => completed = true),
    ));
    expect(find.text('每天都有新试炼'), findsOneWidget);
    await tester.tap(find.text('下一步'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('下一步'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('开始游戏'));
    await tester.pumpAndSettle();
    expect(completed, isTrue);
    expect(
        (await SharedPreferences.getInstance())
            .getBool('onboarding_complete_v1'),
        isTrue);
  });
}
