import 'package:flutter/material.dart';

import 'generated/l10n.dart';
import 'theme/app_theme.dart';
import 'widgets/game_button.dart';

class GamePauseCoverPage extends StatelessWidget {
  final String bg;
  const GamePauseCoverPage({super.key, required this.bg});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(fit: StackFit.expand, children: [
          Image.asset('assets/image/$bg.jpg', fit: BoxFit.cover),
          ColoredBox(color: GameTheme.of(context).scrim),
          SafeArea(
              child: Center(
                  child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Card(
              margin: const EdgeInsets.all(AppSpacing.lg),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.pause_circle_filled_rounded,
                      size: 64, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: AppSpacing.md),
                  Text('Paused',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Your board is waiting.',
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                      width: double.infinity,
                      child: PauseButton(
                        text: S.of(context).Continue,
                        onPressed: () => Navigator.pop(context),
                      )),
                ]),
              ),
            ),
          ))),
        ]),
      );
}
