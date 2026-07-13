import 'package:flutter/material.dart';

import 'audio_service.dart';
import 'generated/l10n.dart';
import 'theme/app_theme.dart';

class SettingsSheet extends StatefulWidget {
  const SettingsSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (_) => const SettingsSheet(),
      );

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  final audio = GameAudioService.instance;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final choices = <(String, String)>[
      ('off', s.Music_Off),
      ('forest', s.Music_Forest),
      ('meditation', s.Music_Meditation),
      ('medieval', s.Music_Medieval),
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(s.Settings, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.md),
            Text(s.Background_Music,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            ...choices.map((choice) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(choice.$1 == 'off'
                      ? Icons.music_off_rounded
                      : Icons.music_note_rounded),
                  title: Text(choice.$2),
                  trailing: audio.musicChoice == choice.$1
                      ? const Icon(Icons.check_circle_rounded)
                      : null,
                  onTap: () async {
                    await audio.setMusic(choice.$1);
                    if (mounted) setState(() {});
                  },
                )),
            const Divider(),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.surround_sound_rounded),
              title: Text(s.Sound_Effects),
              value: audio.soundEffects,
              onChanged: (value) async {
                await audio.setSoundEffects(value);
                if (mounted) setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
