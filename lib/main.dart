import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'config/ad_config.dart';
import 'game_page.dart';
import 'generated/l10n.dart';
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
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

final RouteObserver<ModalRoute<dynamic>> routeObserver =
    RouteObserver<ModalRoute<dynamic>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: '2048',
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
        home: const GameChoose(),
      );
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
                    Text('2048',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface)),
                    const SizedBox(height: AppSpacing.xs),
                    Text('Choose Game Mode',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface)),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                        'Pick a board and how many new tiles appear after each move.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onInverseSurface
                                .withValues(alpha: .86))),
                    const SizedBox(height: AppSpacing.xl),
                    _mode(context, 4, 1, 'bg1', 'Classic · one new tile',
                        Icons.auto_awesome_rounded),
                    _mode(context, 5, 1, 'bg2', 'More room · relaxed pace'),
                    _mode(context, 5, 2, 'bg3', 'More room · faster challenge'),
                    _mode(context, 6, 2, 'bg4', 'Large board · strategic'),
                    _mode(context, 6, 3, 'bg5', 'Large board · expert'),
                  ]),
            ))),
            const AdBanner(),
          ])),
        ]),
      );

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
