import 'generated/l10n.dart';

enum ChallengeKind { classic, sprint, moveLimit, daily }

class ChallengeConfig {
  final ChallengeKind kind;
  final String title;
  final int? seconds;
  final int? moveLimit;
  final int? seed;

  const ChallengeConfig._(this.kind, this.title,
      {this.seconds, this.moveLimit, this.seed});
  const ChallengeConfig.classic() : this._(ChallengeKind.classic, 'Classic');
  const ChallengeConfig.sprint(int seconds)
      : this._(ChallengeKind.sprint, 'Sprint', seconds: seconds);
  const ChallengeConfig.moveLimit(int moves)
      : this._(ChallengeKind.moveLimit, 'Move Challenge', moveLimit: moves);
  factory ChallengeConfig.daily(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return ChallengeConfig._(ChallengeKind.daily, 'Daily Challenge',
        moveLimit: 100,
        seed: day.millisecondsSinceEpoch ~/ Duration.millisecondsPerDay);
  }

  String get id => kind == ChallengeKind.daily
      ? 'daily-$seed'
      : '${kind.name}-${seconds ?? moveLimit ?? 0}';
  String get subtitle => switch (kind) {
        ChallengeKind.classic => 'Endless strategy',
        ChallengeKind.sprint => '${seconds! ~/ 60} minute score race',
        ChallengeKind.moveLimit => 'Highest score in $moveLimit moves',
        ChallengeKind.daily => 'Same 100-move puzzle for everyone',
      };

  String localizedTitle(S s) => switch (kind) {
        ChallengeKind.classic => s.Classic,
        ChallengeKind.sprint => s.Sprint,
        ChallengeKind.moveLimit => s.Move_Challenge,
        ChallengeKind.daily => s.Daily_Challenge,
      };
  String localizedSubtitle(S s) => switch (kind) {
        ChallengeKind.classic => s.Classic_Endless,
        ChallengeKind.sprint => s.Sprint_Subtitle,
        ChallengeKind.moveLimit => s.Move_Subtitle,
        ChallengeKind.daily => s.Daily_Subtitle,
      };
}
