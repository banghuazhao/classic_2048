import 'package:classic_2048/challenge.dart';
import 'package:classic_2048/logic.dart';
import 'package:classic_2048/progress_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('daily challenge is stable for the same calendar day', () {
    final morning = ChallengeConfig.daily(DateTime(2026, 7, 12, 8));
    final evening = ChallengeConfig.daily(DateTime(2026, 7, 12, 20));
    expect(morning.id, evening.id);
    expect(morning.seed, evening.seed);
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
}
