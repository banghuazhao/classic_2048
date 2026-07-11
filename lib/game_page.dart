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
    super.key,
    required this.row,
    required this.newNum,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$row × $row'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          tooltip: S.of(context).Back,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
            tooltip: S.of(context).Continue,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => GamePauseCoverPage(bg: bg))),
            icon: const Icon(Icons.pause_rounded),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GameWidget(
        row: row,
        newNum: newNum,
      ),
    );
  }
}

class _BoardGridWidget extends StatelessWidget {
  final _GameWidgetState _state;

  const _BoardGridWidget(this._state);

  @override
  Widget build(BuildContext context) {
    final boardSize = _state.boardSize();
    final b = BoardConfig.borderWidth;
    final gameTheme = GameTheme.of(context);
    double width =
        (boardSize.width - b * 2 - (_state.column + 1) * _state.cellPadding) /
            _state.column;
    final backgroundBoxes = <CellBox>[];
    for (int r = 0; r < _state.row; ++r) {
      for (int c = 0; c < _state.column; ++c) {
        CellBox box = CellBox(
          left: c * width + _state.cellPadding * (c + 1),
          top: r * width + _state.cellPadding * (r + 1),
          size: width,
          shadowOffset: _state.shadowOffset,
          color: gameTheme.emptyTile,
          text: null,
        );
        backgroundBoxes.add(box);
      }
    }
    return Positioned(
        left: 0.0,
        top: 0.0,
        child: Container(
          width: _state.boardSize().width,
          height: _state.boardSize().height,
          decoration: BoxDecoration(
            border: Border.all(color: gameTheme.boardBorder, width: b),
            color: gameTheme.board,
            borderRadius: AppRadii.board,
          ),
          child: Stack(
            children: backgroundBoxes,
          ),
        ));
  }
}

class GameWidget extends StatefulWidget {
  final int row;
  final int newNum;

  const GameWidget({super.key, required this.row, required this.newNum});

  @override
  State<StatefulWidget> createState() {
    return _GameWidgetState();
  }
}

class _GameWidgetState extends State<GameWidget> {
  late Game _game;
  int row = 4;
  int column = 4;
  int newNum = 1;
  double cellPadding = 10.0;
  double shadowOffset = 2;
  double _boardExtent = 0;
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
    return SafeArea(
      top: false,
      child: LayoutBuilder(builder: (context, constraints) {
        final horizontal = constraints.maxWidth > 600
            ? max(constraints.maxWidth * .1, (constraints.maxWidth - 600) / 2)
            : AppSpacing.sm;
        final width = constraints.maxWidth - horizontal * 2;
        final height = max(180.0, constraints.maxHeight - 154);
        _boardExtent = min(width, height).clamp(180.0, 580.0);
        return Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('${S.of(context).Score}: ',
                  style: Theme.of(context).textTheme.titleMedium),
              Text('${_game.score}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w900)),
            ]),
          ),
          Expanded(
              child: Center(
                  child: SizedBox.square(
            dimension: _boardExtent,
            child: GestureDetector(
              onVerticalDragUpdate: (detail) =>
                  _drag(detail.delta, vertical: true),
              onVerticalDragEnd: (_) => _isDragging = false,
              onVerticalDragCancel: () => _isDragging = false,
              onHorizontalDragUpdate: (detail) => _drag(detail.delta),
              onHorizontalDragEnd: (_) => _isDragging = false,
              onHorizontalDragCancel: () => _isDragging = false,
              child: Stack(children: _boardChildren(context)),
            ),
          ))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Row(children: [
              GameActionButton(
                  icon: Icons.casino_outlined,
                  label: S.of(context).Random,
                  onPressed: _randomMove),
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
            ]),
          ),
          const AdBanner(margin: AppInsets.adContainerGame),
        ]);
      }),
    );
  }

  List<Widget> _boardChildren(BuildContext context) {
    final currentBoardSize = boardSize();
    final b = BoardConfig.borderWidth;
    final tileSize =
        (currentBoardSize.width - b * 2 - (column + 1) * cellPadding) / column;

    List<Widget> tileWidgets = <Widget>[];
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        final cell = _game.get(r, c);
        if (cell.number == 0) continue;

        final left = c * tileSize + b + cellPadding * (c + 1);
        final top = r * tileSize + b + cellPadding * (r + 1);

        tileWidgets.add(
          AnimatedPositioned(
            key: ValueKey(cell.id),
            left: left,
            top: top,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            child: GameTile(
              cell: cell,
              tileSize: tileSize,
              shadowOffset: shadowOffset,
            ),
          ),
        );
      }
    }

    final children = <Widget>[];
    children.add(_BoardGridWidget(this));
    children.addAll(tileWidgets);
    if (_isGameOver) {
      children.add(GameOverOverlay(
        score: _game.score,
        onRestart: newGame,
      ));
    }
    return children;
  }

  void _drag(Offset delta, {bool vertical = false}) {
    if (delta.distance == 0 || _isDragging) return;
    _isDragging = true;
    HapticFeedback.selectionClick();
    if (vertical) {
      delta.dy > 0 ? moveDown() : moveUp();
    } else {
      delta.dx > 0 ? moveRight() : moveLeft();
    }
  }

  void _randomMove() {
    final moves = <VoidCallback>[];
    if (_game.canMoveDown()) moves.add(moveDown);
    if (_game.canMoveLeft()) moves.add(moveLeft);
    if (_game.canMoveRight()) moves.add(moveRight);
    if (_game.canMoveUp()) moves.add(moveUp);
    moves.shuffle();
    if (moves.isNotEmpty) moves.first();
  }

  Size boardSize() {
    return Size.square(_boardExtent);
  }
}

class GameTile extends StatefulWidget {
  final BoardCell cell;
  final double tileSize;
  final double shadowOffset;

  const GameTile({
    super.key,
    required this.cell,
    required this.tileSize,
    required this.shadowOffset,
  });

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;
  bool _playedNew = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    if (widget.cell.isNew) {
      _scaleController.forward();
      widget.cell.isNew = false;
      _playedNew = true;
    } else {
      _scaleController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(GameTile old) {
    super.didUpdateWidget(old);
    if (widget.cell.isNew && !_playedNew) {
      _scaleController.reset();
      _scaleController.forward();
      widget.cell.isNew = false;
      _playedNew = true;
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final number = widget.cell.number;
    return AnimatedBuilder(
      animation: _scaleAnim,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnim.value,
        child: child,
      ),
      child: CellBox(
        left: 0,
        top: 0,
        size: widget.tileSize,
        color: tileColor(number),
        shadowOffset: widget.shadowOffset,
        text: Text(
          number.toString(),
          maxLines: 1,
          style: tileTextStyle(context, number),
        ),
      ),
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
      child: color != GameTheme.of(context).emptyTile
          ? Container(
              width: size,
              height: size,
              padding: AppInsets.cellH5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: AppRadii.tile,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: .28),
                      blurRadius: shadowOffset * 2,
                      offset: Offset(-shadowOffset, -shadowOffset)),
                  BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .shadow
                          .withValues(alpha: .45),
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
            color: GameTheme.of(context).scrim,
            borderRadius: AppRadii.board,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(S.of(context).Game_Over,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.onInverseSurface)),
                const SizedBox(height: 12),
                Text('${S.of(context).Score}: $score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onInverseSurface)),
                const SizedBox(height: 16),
                Text(S.of(context).Game_Over_Message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onInverseSurface)),
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
