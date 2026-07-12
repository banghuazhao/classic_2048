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
      required int seconds}) async {
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
    if (highestTile >= 2048) data['achievement2048'] = true;
    if (score >= 10000) data['achievement10k'] = true;
    if (highestTile >= 512 && moves <= 100) data['achievementEfficient'] = true;
    await prefs.setString(_statsKey, jsonEncode(data));
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
