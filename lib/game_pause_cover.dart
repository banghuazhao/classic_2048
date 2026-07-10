import 'package:classic_2048/generated/l10n.dart';
import 'package:classic_2048/widgets/game_button.dart';
import 'package:flutter/material.dart';

class GamePauseCoverPage extends StatefulWidget {
  final String bg;

  const GamePauseCoverPage({Key? key, required this.bg}) : super(key: key);

  @override
  _GamePauseCoverPageState createState() => _GamePauseCoverPageState();
}

class _GamePauseCoverPageState extends State<GamePauseCoverPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/${widget.bg}.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: PauseButton(
                  text: S.of(context).Continue,
                  onPressed: () => Navigator.pop(context),
                ),
              )),
        ));
  }
}
