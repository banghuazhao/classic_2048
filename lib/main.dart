import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:classic_2048/util/ads_manager.dart';
import 'package:classic_2048/util/in_app_reviewer_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'game_page.dart';
import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Future.delayed(const Duration(seconds: 1), () {
    AppTrackingTransparency.requestTrackingAuthorization();
  });

  MobileAds.instance.initialize();

  AdsManager.debugPrintID();

  InAppReviewHelper.checkAndAskForReview();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });
}

final BoxColors = <int, Color>{
  2: Color(0xffEEEEEE),
  4: Color(0xffB6B6B6),
  8: Color(0xffAAFFA2),
  16: Color(0xff46EB36),
  32: Color(0xff85BCF9),
  64: Color(0xff2D88EC),
  128: Color(0xffCA7EF9),
  256: Color(0xff9800F7),
  512: Color(0xffFAD17A),
  1024: Color(0xffF9B222),
};

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = '2048';
    return MaterialApp(
        title: appTitle,
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
          print(locale);
          // 中文 简繁体处理
          if (locale?.languageCode == 'zh') {
            if (locale?.scriptCode == 'Hant') {
              return const Locale('zh', 'HK'); //繁体
            } else {
              return const Locale('zh', ''); //简体
            }
          }
          return Locale('en', '');
        },
        home: GameChoose());
  }
}

class GameChoose extends StatefulWidget {
  const GameChoose({Key? key}) : super(key: key);

  @override
  _GameChooseState createState() => _GameChooseState();
}

class _GameChooseState extends State<GameChoose> {
  late BannerAd _ad;

  bool _isAdLoaded = false;
  late AppLifecycleReactor _appLifecycleReactor;

  final _appOpenAdManager = AppOpenAdManager();

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      adUnitId: AdsManager.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();

    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: _appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        body: Container(
          decoration: BoxDecoration(
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
                    Container(
                        margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: Center(
                          child: Text(
                            "2048",
                            style: TextStyle(
                                color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: Text(
                          "Choose Game Mode",
                          style: TextStyle(
                              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Text(
                          "Row × Column (new cell per move)",
                          style: TextStyle(
                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    _buildLevelButton(context, 4, 1, "bg1"),
                    _buildLevelButton(context, 5, 1, "bg2"),
                    _buildLevelButton(context, 5, 2, "bg3"),
                    _buildLevelButton(context, 6, 2, "bg4"),
                    _buildLevelButton(context, 6, 3, "bg5"),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                if (_isAdLoaded)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: AdWidget(ad: _ad),
                      height: 50.0,
                    ),
                  ),
              ],
            ),
          ),
        ));
  }

  Container _buildLevelButton(BuildContext context, int row, int newNum, String background) {
    return Container(
      margin: EdgeInsets.only(bottom: 28, left: 40, right: 40),
      height: 60,
      child: Container(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GamePage(
                  row: row,
                  newNum: newNum,
                  bg: background,
                ),
              ),
            );
          },
          child: Text(
            "$row × $row ($newNum)",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff373C69)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))),
        ),
      ),
    );
  }
}
