import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

class GameActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool selected;

  const GameActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final game = GameTheme.of(context);
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: Ink(
          decoration: BoxDecoration(
            color: selected ? game.accent.withValues(alpha: .16) : null,
            borderRadius: BorderRadius.circular(AppRadii.control),
            border: selected ? Border.all(color: game.accent) : null,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.control),
            onTap: () {
              HapticFeedback.lightImpact();
              onPressed();
            },
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 58),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: game.accent),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: game.accent,
                                fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback onPressed;

  const PrimaryButton(
      {super.key,
      required this.text,
      this.subtitle,
      this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) => FilledButton.tonal(
        onPressed: () {
          HapticFeedback.mediumImpact();
          onPressed();
        },
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          alignment: Alignment.centerLeft,
        ),
        child: Row(children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(icon ?? Icons.grid_view_rounded),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(text,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w800)),
                if (subtitle != null)
                  Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
              ])),
          const Icon(Icons.chevron_right_rounded),
        ]),
      );
}

class PauseButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const PauseButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) => FilledButton.icon(
        onPressed: () {
          HapticFeedback.lightImpact();
          onPressed();
        },
        icon: const Icon(Icons.play_arrow_rounded),
        label: Text(text),
      );
}
