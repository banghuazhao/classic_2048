import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/ad_config.dart';
import 'challenge.dart';
import 'game_page.dart';
import 'game_center_service.dart';
import 'generated/l10n.dart';
import 'onboarding.dart';
import 'progress_store.dart';
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
                    Text(S.of(context).App_Name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface)),
                    const SizedBox(height: AppSpacing.xs),
                    Text(S.of(context).Choose_Mode,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface)),
                    const SizedBox(height: AppSpacing.xs),
                    Text(S.of(context).Home_Description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onInverseSurface
                                .withValues(alpha: .86))),
                    const SizedBox(height: AppSpacing.xl),
                    _section(context, S.of(context).Today),
                    _challenge(context, ChallengeConfig.daily(DateTime.now()),
                        Icons.calendar_today_rounded),
                    _section(context, S.of(context).Challenge_Modes),
                    _challenge(context, const ChallengeConfig.sprint(180),
                        Icons.timer_rounded),
                    _challenge(context, const ChallengeConfig.moveLimit(100),
                        Icons.route_rounded),
                    _section(context, S.of(context).Classic_Boards),
                    _mode(context, 4, 1, 'bg1', S.of(context).Mode_4_1,
                        Icons.auto_awesome_rounded),
                    _mode(context, 5, 1, 'bg2', S.of(context).Mode_5_1),
                    _mode(context, 5, 2, 'bg3', S.of(context).Mode_5_2),
                    _mode(context, 6, 2, 'bg4', S.of(context).Mode_6_2),
                    _mode(context, 6, 3, 'bg5', S.of(context).Mode_6_3),
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

  Widget _mode(
          BuildContext context, int row, int count, String bg, String subtitle,
          [IconData? icon]) =>
      Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: PrimaryButton(
            text: '$row × $row',
            subtitle: subtitle,
            icon: icon,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => GamePage(row: row, newNum: count, bg: bg))),
          ));
}
