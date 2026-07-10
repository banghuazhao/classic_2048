import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:classic_2048/config/ad_config.dart';
import 'package:classic_2048/theme/app_theme.dart';
import 'package:classic_2048/util/ads_manager.dart';
import 'package:classic_2048/widgets/ad_banner.dart';
import 'package:classic_2048/widgets/game_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'game_page.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AdConfig.initialize();

  Future.delayed(const Duration(seconds: 1), () {
    AppTrackingTransparency.requestTrackingAuthorization();
  });

  MobileAds.instance.initialize();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '2048',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorObservers: [routeObserver],
        supportedLocales: S.delegate.supportedLocales,
        localeResolutionCallback: (locale, supportLocales) {
          if (locale?.languageCode == 'zh') {
            if (locale?.scriptCode == 'Hant') {
              return const Locale('zh', 'HK');
            } else {
              return const Locale('zh', '');
            }
          }
          return const Locale('en', '');
        },
        home: const GameChoose());
  }
}

class GameChoose extends StatefulWidget {
  const GameChoose({Key? key}) : super(key: key);

  @override
  _GameChooseState createState() => _GameChooseState();
}

class _GameChooseState extends State<GameChoose> {
  @override
  void initState() {
    super.initState();
    final appOpenAdManager = AppOpenAdManager()..loadAd();
    WidgetsBinding.instance
        .addObserver(AppLifecycleReactor(appOpenAdManager: appOpenAdManager));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Center(
                        child: Text("2048", style: AppTextStyles.gameTitle),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Text(
                        "Choose Game Mode",
                        style: AppTextStyles.modeSubtitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Text(
                        "Row × Column (new cell per move)",
                        style: AppTextStyles.description,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      text: "4 × 4 (1)",
                      onPressed: () => _startGame(context, 4, 1, "bg1"),
                    ),
                    PrimaryButton(
                      text: "5 × 5 (1)",
                      onPressed: () => _startGame(context, 5, 1, "bg2"),
                    ),
                    PrimaryButton(
                      text: "5 × 5 (2)",
                      onPressed: () => _startGame(context, 5, 2, "bg3"),
                    ),
                    PrimaryButton(
                      text: "6 × 6 (2)",
                      onPressed: () => _startGame(context, 6, 2, "bg4"),
                    ),
                    PrimaryButton(
                      text: "6 × 6 (3)",
                      onPressed: () => _startGame(context, 6, 3, "bg5"),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: AdBanner(),
                ),
              ],
            ),
          ),
        ));
  }

  void _startGame(BuildContext context, int row, int newNum, String bg) {
    HapticFeedback.mediumImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GamePage(
          row: row,
          newNum: newNum,
          bg: bg,
        ),
      ),
    );
  }
}
