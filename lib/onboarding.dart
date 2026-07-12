import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'theme/app_theme.dart';

class OnboardingPage extends StatefulWidget {
  final VoidCallback onComplete;
  const OnboardingPage({super.key, required this.onComplete});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _page = 0;

  Future<void> _next() async {
    if (_page < 2) {
      await _controller.nextPage(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic);
      return;
    }
    await (await SharedPreferences.getInstance())
        .setBool('onboarding_complete_v1', true);
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final pages = [
      (Icons.calendar_month_rounded, s.Onboarding_Title_1, s.Onboarding_Body_1),
      (Icons.bolt_rounded, s.Onboarding_Title_2, s.Onboarding_Body_2),
      (Icons.emoji_events_rounded, s.Onboarding_Title_3, s.Onboarding_Body_3),
    ];
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(children: [
        Expanded(
            child: PageView.builder(
          controller: _controller,
          itemCount: pages.length,
          onPageChanged: (value) => setState(() => _page = value),
          itemBuilder: (context, index) {
            final page = pages[index];
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(page.$1,
                      size: 104, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: AppSpacing.xl),
                  Text(page.$2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: AppSpacing.md),
                  Text(page.$3,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge),
                ]);
          },
        )),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => Container(
                    width: index == _page ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: index == _page
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(20))))),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
            width: double.infinity,
            child: FilledButton(
                onPressed: _next,
                child: Text(_page == 2 ? s.Start_Playing : s.Next))),
      ]),
    )));
  }
}
