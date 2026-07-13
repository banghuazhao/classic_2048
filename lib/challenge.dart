import 'generated/l10n.dart';

enum ChallengeKind { classic, zen, sprint, moveLimit, daily, level, objective }

enum ChallengeDifficulty { easy, medium, hard }

enum ChallengeGoal { endless, score, tile, timedScore, moveScore, goldenTile }

class ChallengeConfig {
  final ChallengeKind kind;
  final ChallengeGoal goal;
  final ChallengeDifficulty? difficulty;
  final int? level;
  final int? seconds;
  final int? moveLimit;
  final int? targetScore;
  final int? targetTile;
  final int? goldenTarget;
  final int? seed;

  const ChallengeConfig._(
    this.kind, {
    this.goal = ChallengeGoal.endless,
    this.difficulty,
    this.level,
    this.seconds,
    this.moveLimit,
    this.targetScore,
    this.targetTile,
    this.goldenTarget,
    this.seed,
  });

  const ChallengeConfig.classic()
      : this._(ChallengeKind.classic, goal: ChallengeGoal.endless);
  const ChallengeConfig.zen()
      : this._(ChallengeKind.zen, goal: ChallengeGoal.endless);
  const ChallengeConfig.sprint(int seconds)
      : this._(ChallengeKind.sprint,
            goal: ChallengeGoal.timedScore, seconds: seconds);
  const ChallengeConfig.moveLimit(int moves)
      : this._(ChallengeKind.moveLimit,
            goal: ChallengeGoal.moveScore, moveLimit: moves);

  factory ChallengeConfig.daily(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return ChallengeConfig._(
      ChallengeKind.daily,
      goal: ChallengeGoal.moveScore,
      moveLimit: 100,
      seed: day.millisecondsSinceEpoch ~/ Duration.millisecondsPerDay,
    );
  }

  static const levels = <ChallengeConfig>[
    ChallengeConfig._(ChallengeKind.level,
        level: 1, goal: ChallengeGoal.score, targetScore: 500),
    ChallengeConfig._(ChallengeKind.level,
        level: 2, goal: ChallengeGoal.tile, targetTile: 64),
    ChallengeConfig._(ChallengeKind.level,
        level: 3,
        goal: ChallengeGoal.moveScore,
        targetScore: 1200,
        moveLimit: 80),
    ChallengeConfig._(ChallengeKind.level,
        level: 4, goal: ChallengeGoal.goldenTile, goldenTarget: 48),
    ChallengeConfig._(ChallengeKind.level,
        level: 5,
        goal: ChallengeGoal.timedScore,
        targetScore: 2500,
        seconds: 240),
    ChallengeConfig._(ChallengeKind.level,
        level: 6, goal: ChallengeGoal.tile, targetTile: 256),
    ChallengeConfig._(ChallengeKind.level,
        level: 7,
        goal: ChallengeGoal.goldenTile,
        goldenTarget: 96,
        moveLimit: 130),
    ChallengeConfig._(ChallengeKind.level,
        level: 8,
        goal: ChallengeGoal.moveScore,
        targetScore: 7000,
        moveLimit: 150),
    ChallengeConfig._(ChallengeKind.level,
        level: 9,
        goal: ChallengeGoal.timedScore,
        targetScore: 10000,
        seconds: 300),
    ChallengeConfig._(ChallengeKind.level,
        level: 10,
        goal: ChallengeGoal.goldenTile,
        goldenTarget: 192,
        moveLimit: 180),
  ];

  static const challenges = <ChallengeConfig>[
    ChallengeConfig._(ChallengeKind.objective,
        difficulty: ChallengeDifficulty.easy,
        goal: ChallengeGoal.score,
        targetScore: 800),
    ChallengeConfig._(ChallengeKind.objective,
        difficulty: ChallengeDifficulty.easy,
        goal: ChallengeGoal.tile,
        targetTile: 64),
    ChallengeConfig._(ChallengeKind.objective,
        difficulty: ChallengeDifficulty.easy,
        goal: ChallengeGoal.timedScore,
        targetScore: 1200,
        seconds: 150),
    ChallengeConfig._(ChallengeKind.objective,
        difficulty: ChallengeDifficulty.medium,
        goal: ChallengeGoal.moveScore,
        targetScore: 3000,
        moveLimit: 90),
    ChallengeConfig._(ChallengeKind.objective,
        difficulty: ChallengeDifficulty.medium,
        goal: ChallengeGoal.tile,
        targetTile: 256,
        moveLimit: 140),
    ChallengeConfig._(ChallengeKind.objective,
        difficulty: ChallengeDifficulty.medium,
        goal: ChallengeGoal.goldenTile,
        goldenTarget: 64),
    ChallengeConfig._(ChallengeKind.objective,
        difficulty: ChallengeDifficulty.hard,
        goal: ChallengeGoal.timedScore,
        targetScore: 8000,
        seconds: 210),
    ChallengeConfig._(ChallengeKind.objective,
        difficulty: ChallengeDifficulty.hard,
        goal: ChallengeGoal.moveScore,
        targetScore: 10000,
        moveLimit: 130),
    ChallengeConfig._(ChallengeKind.objective,
        difficulty: ChallengeDifficulty.hard,
        goal: ChallengeGoal.goldenTile,
        goldenTarget: 192,
        moveLimit: 170),
  ];

  bool get hasGolden => goldenTarget != null;

  String get id {
    if (kind == ChallengeKind.daily) return 'daily-$seed';
    if (kind == ChallengeKind.level) return 'level-$level';
    if (kind == ChallengeKind.objective) {
      return 'challenge-${difficulty!.name}-${goal.name}-${targetScore ?? targetTile ?? goldenTarget}';
    }
    return '${kind.name}-${seconds ?? moveLimit ?? 0}';
  }

  String localizedTitle(S s) => switch (kind) {
        ChallengeKind.classic => s.Classic,
        ChallengeKind.zen => s.Zen_Mode,
        ChallengeKind.sprint => s.Sprint,
        ChallengeKind.moveLimit => s.Move_Challenge,
        ChallengeKind.daily => s.Daily_Challenge,
        ChallengeKind.level => s.Level_Number(level!),
        ChallengeKind.objective =>
          '${_localizedDifficulty(s)} · ${_localizedGoal(s)}',
      };

  String localizedObjective(S s) => switch (goal) {
        ChallengeGoal.endless => s.Objective_Endless,
        ChallengeGoal.score => s.Objective_Score(targetScore!),
        ChallengeGoal.tile => s.Objective_Tile(targetTile!),
        ChallengeGoal.timedScore => targetScore == null
            ? s.Objective_Time(seconds!)
            : s.Objective_Timed_Score(targetScore!, seconds!),
        ChallengeGoal.moveScore => targetScore == null
            ? s.Objective_Moves(moveLimit!)
            : s.Objective_Move_Score(targetScore!, moveLimit!),
        ChallengeGoal.goldenTile => s.Objective_Golden(goldenTarget!),
      };

  String localizedSubtitle(S s) => switch (kind) {
        ChallengeKind.classic => s.Classic_Endless,
        ChallengeKind.zen => s.Zen_Subtitle,
        ChallengeKind.sprint => s.Sprint_Subtitle,
        ChallengeKind.moveLimit => s.Move_Subtitle,
        ChallengeKind.daily => s.Daily_Subtitle,
        ChallengeKind.level || ChallengeKind.objective => localizedObjective(s),
      };

  String _localizedDifficulty(S s) => switch (difficulty!) {
        ChallengeDifficulty.easy => s.Easy,
        ChallengeDifficulty.medium => s.Medium,
        ChallengeDifficulty.hard => s.Hard,
      };

  String _localizedGoal(S s) => switch (goal) {
        ChallengeGoal.score => s.Score_Goal,
        ChallengeGoal.tile => s.Tile_Goal,
        ChallengeGoal.timedScore => s.Speed_Goal,
        ChallengeGoal.moveScore => s.Move_Goal,
        ChallengeGoal.goldenTile => s.Golden_Goal,
        ChallengeGoal.endless => s.Zen_Mode,
      };
}
