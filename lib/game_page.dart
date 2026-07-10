import 'dart:math';

import 'package:classic_2048/game_pause_cover.dart';
import 'package:classic_2048/theme/app_theme.dart';
import 'package:classic_2048/widgets/ad_banner.dart';
import 'package:classic_2048/widgets/game_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'generated/l10n.dart';
import 'logic.dart';

class GamePage extends StatelessWidget {
  final int row;
  final int newNum;
  final String bg;

  const GamePage({
    Key? key,
    required this.row,
    required this.newNum,
    required this.bg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double safePadding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    double widthFinal = width;

    double marginWidth = 10;
    if (width >= 600) {
      marginWidth = max(width * 0.1, (width - 600) / 2);
      widthFinal = width - marginWidth * 2 + 20;
    }

    double barHeight = max(height - widthFinal - safePadding - 160, 1);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(barHeight),
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                tooltip: S.of(context).Back,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
            flexibleSpace: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GamePauseCoverPage(bg: bg)));
              },
              child: Image(
                image: AssetImage('assets/image/$bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0),
      ),
      backgroundColor: AppColors.background,
      body: GameWidget(
        row: row,
        newNum: newNum,
      ),
    );
  }
}

class BoardGridWidget extends StatelessWidget {
  final _GameWidgetState _state;

  const BoardGridWidget(this._state);

  @override
  Widget build(BuildContext context) {
    final boardSize = _state.boardSize();
    final b = BoardConfig.boardBorderWidth;
    double width =
        (boardSize.width - b * 2 - (_state.column + 1) * _state.cellPadding) /
            _state.column;
    List<CellBox> _backgroundBox = <CellBox>[];
    for (int r = 0; r < _state.row; ++r) {
      for (int c = 0; c < _state.column; ++c) {
        CellBox box = CellBox(
          left: c * width + _state.cellPadding * (c + 1),
          top: r * width + _state.cellPadding * (r + 1),
          size: width,
          shadowOffset: _state.shadowOffset,
          color: AppColors.emptyTile,
          text: null,
        );
        _backgroundBox.add(box);
      }
    }
    return Positioned(
        left: 0.0,
        top: 0.0,
        child: Container(
          width: _state.boardSize().width,
          height: _state.boardSize().height,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.boardBorder, width: b),
            color: AppColors.boardBackground,
            borderRadius: AppRadii.board,
          ),
          child: Stack(
            children: _backgroundBox,
          ),
        ));
  }
}

class GameWidget extends StatefulWidget {
  final int row;
  final int newNum;

  const GameWidget({Key? key, required this.row, required this.newNum})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GameWidgetState();
  }
}

class _GameWidgetState extends State<GameWidget> {
  late Game _game;
  late MediaQueryData _queryData;
  int row = 4;
  int column = 4;
  int newNum = 1;
  double cellPadding = 10.0;
  double shadowOffset = 2;
  EdgeInsets _gameMargin = EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0);
  bool _isDragging = false;
  bool _isGameOver = false;

  @override
  void initState() {
    super.initState();

    row = widget.row;
    column = widget.row;
    newNum = widget.newNum;

    cellPadding = BoardConfig.cellPadding(row);
    shadowOffset = BoardConfig.shadowOffset(row);

    _game = Game(row, column, newNum);
    newGame();
  }

  void newGame() {
    _game.init();
    _isGameOver = false;
    setState(() {});
  }

  void moveLeft() {
    setState(() {
      _game.moveLeft();
      checkGameOver();
    });
  }

  void moveRight() {
    setState(() {
      _game.moveRight();
      checkGameOver();
    });
  }

  void moveUp() {
    setState(() {
      _game.moveUp();
      checkGameOver();
    });
  }

  void moveDown() {
    setState(() {
      _game.moveDown();
      checkGameOver();
    });
  }

  void checkGameOver() {
    if (_game.isGameOver()) {
      HapticFeedback.heavyImpact();
      setState(() => _isGameOver = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CellWidget> _cellWidgets = <CellWidget>[];
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        _cellWidgets.add(CellWidget(cell: _game.get(r, c), state: this));
      }
    }
    _queryData = MediaQuery.of(context);

    double width = _queryData.size.width;
    double marginWidth = 10;
    if (width >= 600) {
      marginWidth = max(width * 0.1, (width - 600) / 2);
    }
    _gameMargin = EdgeInsets.fromLTRB(marginWidth, 0.0, marginWidth, 0.0);

    List<Widget> children = <Widget>[];
    children.add(BoardGridWidget(this));
    children.addAll(_cellWidgets);
    if (_isGameOver) {
      children.add(GameOverOverlay(
        score: _game.score,
        onRestart: newGame,
      ));
    }
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
              margin: AppInsets.scoreRow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            S.of(context).Score + ": ",
                            style: AppTextStyles.scoreLabel,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _game.score.toString(),
                            style: AppTextStyles.scoreValue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 10),
          Container(
              margin: _gameMargin,
              width: _queryData.size.width - _gameMargin.left * 2,
              height: _queryData.size.width - _gameMargin.left * 2 + 10,
              child: GestureDetector(
                onVerticalDragUpdate: (detail) {
                  if (detail.delta.distance == 0 || _isDragging) return;
                  _isDragging = true;
                  HapticFeedback.selectionClick();
                  if (detail.delta.direction > 0) {
                    moveDown();
                  } else {
                    moveUp();
                  }
                },
                onVerticalDragEnd: (detail) {
                  _isDragging = false;
                },
                onVerticalDragCancel: () {
                  _isDragging = false;
                },
                onHorizontalDragUpdate: (detail) {
                  if (detail.delta.distance == 0 || _isDragging) return;
                  _isDragging = true;
                  HapticFeedback.selectionClick();
                  if (detail.delta.direction > 0) {
                    moveLeft();
                  } else {
                    moveRight();
                  }
                },
                onHorizontalDragEnd: (detail) {
                  _isDragging = false;
                },
                onHorizontalDragCancel: () {
                  _isDragging = false;
                },
                child: Stack(
                  children: children,
                ),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(
                10 + MediaQuery.of(context).padding.left,
                12,
                10 + MediaQuery.of(context).padding.right,
                max(4, MediaQuery.of(context).padding.bottom)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              GameActionButton(
                  icon: Icons.casino_outlined,
                  label: S.of(context).Random,
                  onPressed: () {
                    var arr = <int>[];
                    if (_game.canMoveDown()) arr.add(1);
                    if (_game.canMoveLeft()) arr.add(2);
                    if (_game.canMoveRight()) arr.add(3);
                    if (_game.canMoveUp()) arr.add(4);

                    arr.shuffle();

                    if (arr.isNotEmpty) {
                      int num = arr.first;
                      if (num == 1) {
                        moveDown();
                      } else if (num == 2) {
                        moveLeft();
                      } else if (num == 3) {
                        moveRight();
                      } else if (num == 4) {
                        moveUp();
                      }
                    }

                    setState(() {});
                  }),
              GameActionButton(
                  icon: Icons.shuffle_rounded,
                  label: S.of(context).Shuffle,
                  onPressed: () {
                    _game.shuffle();
                    setState(() {});
                  }),
              GameActionButton(
                  icon: Icons.refresh_rounded,
                  label: S.of(context).Restart,
                  onPressed: newGame),
            ],
          ),
        ),
        const Spacer(),
          const AdBanner(margin: AppInsets.adContainerGame),
        ],
      ),
    );
  }

  Size boardSize() {
    Size size = _queryData.size;
    double width = size.width - _gameMargin.left - _gameMargin.right;
    return Size(width, width);
  }
}

class AnimatedCellWidget extends AnimatedWidget {
  final BoardCell cell;
  final _GameWidgetState state;

  const AnimatedCellWidget({
    Key? key,
    required this.cell,
    required this.state,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    double animationValue = animation.value;
    Size boardSize = state.boardSize();
    final b = BoardConfig.boardBorderWidth;
    double width =
        (boardSize.width - b * 2 - (state.column + 1) * state.cellPadding) /
            state.column;

    if (cell.number == 0) {
      return Container();
    }

    return CellBox(
      left:
          (cell.column * width + b + state.cellPadding * (cell.column + 1)) +
              width / 2 * (1 - animationValue),
      top: cell.row * width +
          b +
          state.cellPadding * (cell.row + 1) +
          width / 2 * (1 - animationValue),
      size: width * animationValue,
      color: tileColor(cell.number),
      shadowOffset: state.shadowOffset,
      text: Text(
        cell.number.toString(),
        maxLines: 1,
        style: TextStyle(
          fontSize: tileFontSize(cell.number, animationValue),
          fontWeight: FontWeight.w900,
          color: tileTextColor(cell.number),
        ),
      ),
    );
  }
}

class CellWidget extends StatefulWidget {
  final BoardCell cell;
  final _GameWidgetState state;

  const CellWidget({required this.cell, required this.state});

  @override
  _CellWidgetState createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
    widget.cell.isNew = false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cell.isNew && !widget.cell.isEmpty()) {
      controller.reset();
      controller.forward();
      widget.cell.isNew = false;
    } else {
      controller.animateTo(1.0);
    }
    return AnimatedCellWidget(
      cell: widget.cell,
      state: widget.state,
      animation: animation,
    );
  }
}

class CellBox extends StatelessWidget {
  final double left;
  final double top;
  final double size;
  final Color color;
  final double shadowOffset;
  final Text? text;

  const CellBox({
    super.key,
    required this.left,
    required this.top,
    required this.size,
    required this.color,
    required this.shadowOffset,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: color != AppColors.emptyTile
          ? Container(
              width: size,
              height: size,
              padding: AppInsets.cellH5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: AppRadii.tile,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.white50,
                      blurRadius: shadowOffset * 2,
                      offset: Offset(-shadowOffset, -shadowOffset)),
                  BoxShadow(
                      color: AppColors.black50,
                      blurRadius: shadowOffset * 2,
                      offset: Offset(shadowOffset, shadowOffset)),
                ],
              ),
              child: Center(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: text)),
            )
          : Container(
              width: size,
              height: size,
              padding: AppInsets.cellH5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: AppRadii.tile,
              ),
              child: Center(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: text)),
            ),
    );
  }
}

class GameOverOverlay extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  const GameOverOverlay({
    super.key,
    required this.score,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.darkOverlay,
            borderRadius: AppRadii.board,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(S.of(context).Game_Over,
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white)),
                const SizedBox(height: 12),
                Text(S.of(context).Score + ": $score",
                    style: const TextStyle(
                        fontSize: 22, color: AppColors.white70)),
                const SizedBox(height: 16),
                Text(S.of(context).Game_Over_Message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, color: AppColors.white70)),
                const SizedBox(height: 28),
                PauseButton(
                  text: S.of(context).Restart,
                  onPressed: onRestart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
