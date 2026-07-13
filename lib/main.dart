import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/ad_config.dart';
import 'audio_service.dart';
import 'challenge.dart';
import 'game_page.dart';
import 'game_center_service.dart';
import 'generated/l10n.dart';
import 'onboarding.dart';
import 'mode_catalog.dart';
import 'progress_store.dart';
import 'settings_sheet.dart';
import 'theme/app_theme.dart';
import 'util/ads_manager.dart';
import 'widgets/ad_banner.dart';
import 'widgets/game_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdConfig.initialize();
  Future.delayed(const Duration(seconds: 1),
      AppTrackingTransparency.requestTrackingAuthorization);
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

final RouteObserver<ModalRoute<dynamic>> routeObserver =
    RouteObserver<ModalRoute<dynamic>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateTitle: (context) => S.of(context).App_Name,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        navigatorObservers: [routeObserver],
        supportedLocales: S.delegate.supportedLocales,
        localeResolutionCallback: (locale, _) => locale?.languageCode == 'zh'
            ? Locale('zh', locale?.scriptCode == 'Hant' ? 'HK' : '')
            : const Locale('en'),
        home: const LaunchGate(),
      );
}

class LaunchGate extends StatefulWidget {
  const LaunchGate({super.key});
  @override
  State<LaunchGate> createState() => _LaunchGateState();
}

class _LaunchGateState extends State<LaunchGate> {
  bool? _complete;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (mounted) {
        setState(
            () => _complete = prefs.getBool('onboarding_complete_v1') ?? false);
      }
    });
    GameCenterService().signIn();
    GameAudioService.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    if (_complete == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_complete!) return const GameChoose();
    return OnboardingPage(onComplete: () => setState(() => _complete = true));
  }
}

class GameChoose extends StatefulWidget {
  const GameChoose({super.key});
  @override
  State<GameChoose> createState() => _GameChooseState();
}

class _GameChooseState extends State<GameChoose> {
  @override
  void initState() {
    super.initState();
    final manager = AppOpenAdManager()..loadAd();
    WidgetsBinding.instance
        .addObserver(AppLifecycleReactor(appOpenAdManager: manager));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(fit: StackFit.expand, children: [
          const DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/bg.jpg'),
                      fit: BoxFit.cover))),
          DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                GameTheme.of(context).scrim.withValues(alpha: .18),
                GameTheme.of(context).scrim.withValues(alpha: .58)
              ]))),
          SafeArea(
              child: Column(children: [
            Expanded(
                child: Center(
                    child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                  children: [
                    Row(children: [
                      Expanded(
                        child: Text(S.of(context).App_Name,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onInverseSurface,
                                    fontWeight: FontWeight.w900)),
                      ),
                      IconButton.filledTonal(
                        tooltip: S.of(context).Settings,
                        onPressed: () => SettingsSheet.show(context),
                        icon: const Icon(Icons.settings_rounded),
                      ),
                    ]),
                    const SizedBox(height: AppSpacing.lg),
                    _section(context, S.of(context).Today),
                    _challenge(context, ChallengeConfig.daily(DateTime.now()),
                        Icons.calendar_today_rounded),
                    const SizedBox(height: AppSpacing.sm),
                    _featureGrid(context),
                    _section(context, S.of(context).Classic_Boards),
                    _classicGrid(context),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton.icon(
                        onPressed: () => _showStats(context),
                        icon: const Icon(Icons.insights_rounded),
                        label: Text(S.of(context).Progress_Achievements)),
                  ]),
            ))),
            const AdBanner(),
          ])),
        ]),
      );

  Widget _section(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
        child: Text(text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onInverseSurface,
                fontWeight: FontWeight.w900)),
      );

  Widget _challenge(
          BuildContext context, ChallengeConfig challenge, IconData icon) =>
      Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: PrimaryButton(
            text: challenge.localizedTitle(S.of(context)),
            subtitle: challenge.localizedSubtitle(S.of(context)),
            icon: icon,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => GamePage(
                        row: 4, newNum: 1, bg: 'bg1', challenge: challenge))),
          ));

  Widget _featureGrid(BuildContext context) {
    final s = S.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      final columns = constraints.maxWidth >= 520 ? 3 : 2;
      final width =
          (constraints.maxWidth - (columns - 1) * AppSpacing.sm) / columns;
      return Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          _featureCard(context,
              width: width,
              title: s.Levels,
              subtitle: s.All_Levels,
              icon: Icons.stairs_rounded,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ModeCatalogPage.levels()))),
          _featureCard(context,
              width: width,
              title: s.Zen_Mode,
              subtitle: s.Zen_Subtitle,
              icon: Icons.all_inclusive_rounded,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const GamePage(
                          row: 4,
                          newNum: 1,
                          bg: 'bg2',
                          challenge: ChallengeConfig.zen())))),
          _featureCard(context,
              width: width,
              title: s.Challenges,
              subtitle: s.Challenge_Count,
              icon: Icons.emoji_events_rounded,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ModeCatalogPage.challenges()))),
        ],
      );
    });
  }

  Widget _featureCard(BuildContext context,
          {required double width,
          required String title,
          required String subtitle,
          required IconData icon,
          required VoidCallback onTap}) =>
      SizedBox(
        width: width,
        height: 150,
        child: Card(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: .92),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: Theme.of(context).colorScheme.primary),
                  const Spacer(),
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _classicGrid(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final columns = constraints.maxWidth >= 520 ? 3 : 2;
        final modes = const [
          (4, 1, 'bg1'),
          (5, 1, 'bg2'),
          (5, 2, 'bg3'),
          (6, 2, 'bg4'),
          (6, 3, 'bg5'),
        ];
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: modes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: 1.7,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
          ),
          itemBuilder: (context, index) {
            final mode = modes[index];
            return FilledButton.tonalIcon(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => GamePage(
                          row: mode.$1, newNum: mode.$2, bg: mode.$3))),
              icon: const Icon(Icons.grid_view_rounded),
              label: Text('${mode.$1} × ${mode.$1}',
                  style: const TextStyle(fontWeight: FontWeight.w900)),
            );
          },
        );
      });

  Future<void> _showStats(BuildContext context) async {
    final stats = await ProgressStore().stats();
    if (!context.mounted) return;
    final achievements = <String>[
      if (stats['achievement2048'] == true) S.of(context).Achievement_2048,
      if (stats['achievement10k'] == true) S.of(context).Achievement_10K,
      if (stats['achievementEfficient'] == true)
        S.of(context).Achievement_Efficient,
      if (stats['achievementStreak7'] == true) S.of(context).Achievement_Streak,
    ];
    await showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (context) => SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).Your_Progress,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: AppSpacing.md),
                    Text(S.of(context).Games_Moves(
                        stats['games'] ?? 0, stats['totalMoves'] ?? 0)),
                    Text(S.of(context).Best_Highest(
                        stats['bestScore'] ?? 0, stats['highestTile'] ?? 0)),
                    const SizedBox(height: AppSpacing.md),
                    Text(S.of(context).Day_Streak(stats['dailyStreak'] ?? 0),
                        style: Theme.of(context).textTheme.titleMedium),
                    Text((stats['dailyHistory'] as List<dynamic>? ?? const [])
                            .isEmpty
                        ? S.of(context).No_Daily_History
                        : (stats['dailyHistory'] as List<dynamic>)
                            .reversed
                            .take(7)
                            .join('  •  ')),
                    const SizedBox(height: AppSpacing.lg),
                    Text(S.of(context).Achievements,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.xs),
                    Text(achievements.isEmpty
                        ? S.of(context).No_Achievements
                        : achievements.join('  •  ')),
                    if (GameCenterService.supported)
                      Row(children: [
                        Expanded(
                            child: TextButton.icon(
                                onPressed: GameCenterService().showLeaderboards,
                                icon: const Icon(Icons.leaderboard_rounded),
                                label: Text(S.of(context).Leaderboards))),
                        Expanded(
                            child: TextButton.icon(
                                onPressed: GameCenterService().showAchievements,
                                icon: const Icon(Icons.emoji_events_rounded),
                                label: Text(S.of(context).Achievements))),
                      ]),
                  ]),
            )));
  }
}
