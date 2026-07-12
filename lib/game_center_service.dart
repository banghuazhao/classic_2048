import 'dart:io';

import 'package:games_services/games_services.dart';

class GameCenterIds {
  GameCenterIds._();
  static const classicLeaderboard = 'com.appsbay.classic2048.classic';
  static const sprintLeaderboard = 'com.appsbay.classic2048.sprint';
  static const dailyLeaderboard = 'com.appsbay.classic2048.daily';
  static const achievement2048 = 'com.appsbay.classic2048.achievement.2048';
  static const achievement10k = 'com.appsbay.classic2048.achievement.10k';
  static const achievementEfficient =
      'com.appsbay.classic2048.achievement.efficient';
  static const achievementStreak7 =
      'com.appsbay.classic2048.achievement.streak7';
}

class GameCenterService {
  static bool get supported => Platform.isIOS;

  Future<void> signIn() async {
    if (supported) await GameAuth.signIn();
  }

  Future<void> submit(
      {required String mode,
      required int score,
      required int highestTile,
      required int moves,
      required int streak}) async {
    if (!supported) return;
    final leaderboard = mode.startsWith('daily')
        ? GameCenterIds.dailyLeaderboard
        : mode.startsWith('sprint')
            ? GameCenterIds.sprintLeaderboard
            : GameCenterIds.classicLeaderboard;
    await Leaderboards.submitScore(
        score: Score(iOSLeaderboardID: leaderboard, value: score));
    if (highestTile >= 2048) await _unlock(GameCenterIds.achievement2048);
    if (score >= 10000) await _unlock(GameCenterIds.achievement10k);
    if (highestTile >= 512 && moves <= 100) {
      await _unlock(GameCenterIds.achievementEfficient);
    }
    if (streak >= 7) await _unlock(GameCenterIds.achievementStreak7);
  }

  Future<void> _unlock(String id) => Achievements.unlock(
      achievement: Achievement(iOSID: id, percentComplete: 100));
  Future<void> showLeaderboards() async {
    if (supported) await Leaderboards.showLeaderboards();
  }

  Future<void> showAchievements() async {
    if (supported) await Achievements.showAchievements();
  }
}
