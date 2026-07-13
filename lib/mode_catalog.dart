import 'package:flutter/material.dart';

import 'challenge.dart';
import 'game_page.dart';
import 'generated/l10n.dart';
import 'progress_store.dart';
import 'theme/app_theme.dart';

class ModeCatalogPage extends StatefulWidget {
  final bool levels;

  const ModeCatalogPage.levels({super.key}) : levels = true;
  const ModeCatalogPage.challenges({super.key}) : levels = false;

  @override
  State<ModeCatalogPage> createState() => _ModeCatalogPageState();
}

class _ModeCatalogPageState extends State<ModeCatalogPage> {
  late Future<Map<String, dynamic>> _stats;

  @override
  void initState() {
    super.initState();
    _stats = ProgressStore().stats();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final modes =
        widget.levels ? ChallengeConfig.levels : ChallengeConfig.challenges;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.levels ? s.Levels : s.Challenges),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _stats,
        builder: (context, snapshot) {
          final stats = snapshot.data ?? const <String, dynamic>{};
          final highestLevel = stats['highestLevel'] as int? ?? 0;
          final completed = Set<String>.from(
              stats['completedModes'] as List<dynamic>? ?? const []);
          return LayoutBuilder(builder: (context, constraints) {
            final maxExtent = constraints.maxWidth >= 700 ? 260.0 : 210.0;
            return GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: maxExtent,
                mainAxisExtent: 178,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
              ),
              itemCount: modes.length,
              itemBuilder: (context, index) {
                final mode = modes[index];
                final locked = widget.levels && index > highestLevel;
                return _ModeCard(
                  mode: mode,
                  locked: locked,
                  completed: completed.contains(mode.id),
                  onPressed: () => _open(mode),
                );
              },
            );
          });
        },
      ),
    );
  }

  Future<void> _open(ChallengeConfig mode) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => GamePage(
          row: mode.level != null && mode.level! >= 8 ? 5 : 4,
          newNum: mode.difficulty == ChallengeDifficulty.hard ? 2 : 1,
          bg: 'bg${((mode.level ?? 1) - 1) % 5 + 1}',
          challenge: mode,
        ),
      ),
    );
    if (mounted) setState(() => _stats = ProgressStore().stats());
  }
}

class _ModeCard extends StatelessWidget {
  final ChallengeConfig mode;
  final bool locked;
  final bool completed;
  final VoidCallback onPressed;

  const _ModeCard({
    required this.mode,
    required this.locked,
    required this.completed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: locked ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                CircleAvatar(
                  backgroundColor: mode.hasGolden
                      ? const Color(0xffFFD75E)
                      : scheme.primaryContainer,
                  child: Icon(
                      locked ? Icons.lock_rounded : _goalIcon(mode.goal),
                      color: mode.hasGolden ? Colors.brown.shade900 : null),
                ),
                const Spacer(),
                if (completed)
                  Icon(Icons.check_circle_rounded, color: scheme.primary),
              ]),
              const Spacer(),
              Text(mode.localizedTitle(s),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w900)),
              const SizedBox(height: AppSpacing.xxs),
              Text(locked ? s.Locked : mode.localizedObjective(s),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall),
              if (mode.hasGolden) ...[
                const SizedBox(height: AppSpacing.xs),
                _GoldenBadge(label: s.Golden),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _GoldenBadge extends StatelessWidget {
  final String label;
  const _GoldenBadge({required this.label});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xffFFD75E).withValues(alpha: .28),
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: const Color(0xffD39C00)),
        ),
        child: Text(label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w900)),
      );
}

IconData _goalIcon(ChallengeGoal goal) => switch (goal) {
      ChallengeGoal.endless => Icons.all_inclusive_rounded,
      ChallengeGoal.score => Icons.stars_rounded,
      ChallengeGoal.tile => Icons.grid_4x4_rounded,
      ChallengeGoal.timedScore => Icons.timer_rounded,
      ChallengeGoal.moveScore => Icons.route_rounded,
      ChallengeGoal.goldenTile => Icons.auto_awesome_rounded,
    };
