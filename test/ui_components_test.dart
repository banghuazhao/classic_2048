import 'package:classic_2048/game_page.dart';
import 'package:classic_2048/generated/l10n.dart';
import 'package:classic_2048/theme/app_theme.dart';
import 'package:classic_2048/widgets/game_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Widget harness(Widget child, {double textScale = 1}) => MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, widget) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(textScale)),
        child: widget!,
      ),
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  testWidgets('mode button remains usable at 2x text and invokes action',
      (tester) async {
    var tapped = false;
    await tester.pumpWidget(harness(
        PrimaryButton(
          text: '4 × 4',
          subtitle: 'Classic · one new tile',
          onPressed: () => tapped = true,
        ),
        textScale: 2));
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('4 × 4'));
    expect(tapped, isTrue);
  });

  testWidgets('game over state presents score and restart action',
      (tester) async {
    var restarted = false;
    await tester.pumpWidget(harness(SizedBox.square(
      dimension: 360,
      child: Stack(children: [
        GameOverOverlay(score: 2048, onRestart: () => restarted = true)
      ]),
    )));
    expect(find.textContaining('2048'), findsOneWidget);
    await tester.tap(find.text('Restart'));
    expect(restarted, isTrue);
  });
}
