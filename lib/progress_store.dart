import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProgressStore {
  static const _statsKey = 'challenge_stats_v1';
  static const _saveKey = 'active_game_v1';

  Future<Map<String, dynamic>> stats() async {
    final value = (await SharedPreferences.getInstance()).getString(_statsKey);
    return value == null
        ? <String, dynamic>{}
        : jsonDecode(value) as Map<String, dynamic>;
  }

  Future<void> record(
      {required String mode,
      required int score,
      required int moves,
      required int highestTile,
      required int seconds,
      bool completed = false,
      int? level}) async {
    final prefs = await SharedPreferences.getInstance();
    final data = await stats();
    data['games'] = (data['games'] as int? ?? 0) + 1;
    data['bestScore'] = score > (data['bestScore'] as int? ?? 0)
        ? score
        : data['bestScore'] ?? 0;
    data['highestTile'] = highestTile > (data['highestTile'] as int? ?? 0)
        ? highestTile
        : data['highestTile'] ?? 0;
    data['totalMoves'] = (data['totalMoves'] as int? ?? 0) + moves;
    data['best_$mode'] = score > (data['best_$mode'] as int? ?? 0)
        ? score
        : data['best_$mode'] ?? 0;
    if (completed) {
      final completedModes = List<String>.from(
          data['completedModes'] as List<dynamic>? ?? const []);
      if (!completedModes.contains(mode)) completedModes.add(mode);
      data['completedModes'] = completedModes;
      if (level != null) {
        data['highestLevel'] = level > (data['highestLevel'] as int? ?? 0)
            ? level
            : data['highestLevel'] ?? 0;
      }
    }
    if (highestTile >= 2048) data['achievement2048'] = true;
    if (score >= 10000) data['achievement10k'] = true;
    if (highestTile >= 512 && moves <= 100) data['achievementEfficient'] = true;
    if (mode.startsWith('daily-')) {
      final today = DateTime.now().toIso8601String().substring(0, 10);
      final history =
          List<String>.from(data['dailyHistory'] as List<dynamic>? ?? const []);
      if (!history.contains(today)) history.add(today);
      history.sort();
      data['dailyHistory'] =
          history.length > 31 ? history.sublist(history.length - 31) : history;
      data['dailyStreak'] = _streak(history);
      if ((data['dailyStreak'] as int) >= 7) data['achievementStreak7'] = true;
    }
    await prefs.setString(_statsKey, jsonEncode(data));
  }

  int _streak(List<String> history) {
    final days = history.map(DateTime.parse).toSet();
    final now = DateTime.now();
    var cursor = DateTime(now.year, now.month, now.day);
    if (!days.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    var streak = 0;
    while (days.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  Future<void> save(Map<String, dynamic> game) async =>
      (await SharedPreferences.getInstance())
          .setString(_saveKey, jsonEncode(game));
  Future<Map<String, dynamic>?> load() async {
    final value = (await SharedPreferences.getInstance()).getString(_saveKey);
    return value == null ? null : jsonDecode(value) as Map<String, dynamic>;
  }

  Future<void> clearSave() async =>
      (await SharedPreferences.getInstance()).remove(_saveKey);
}
