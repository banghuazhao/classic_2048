import 'dart:async';
import 'dart:math';

import 'package:classic_2048/game_pause_cover.dart';
import 'package:classic_2048/theme/app_theme.dart';
import 'package:classic_2048/widgets/ad_banner.dart';
import 'package:classic_2048/widgets/game_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'challenge.dart';
import 'audio_service.dart';
import 'generated/l10n.dart';
import 'game_center_service.dart';
import 'logic.dart';
import 'progress_store.dart';

class GamePage extends StatefulWidget {
  final int row;
  final int newNum;
  final String bg;
  final ChallengeConfig challenge;

  const GamePage({
    super.key,
    required this.row,
    required this.newNum,
    required this.bg,
    this.challenge = const ChallengeConfig.classic(),
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _paused = ValueNotifier(false);

  @override
  void dispose() {
    _paused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.challenge.localizedTitle(S.of(context))),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          tooltip: S.of(context).Back,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
            tooltip: S.of(context).Continue,
            onPressed: () async {
              _paused.value = true;
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => GamePauseCoverPage(bg: widget.bg)));
              _paused.value = false;
            },
            icon: const Icon(Icons.pause_rounded),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GameWidget(
        row: widget.row,
        newNum: widget.newNum,
        challenge: widget.challenge,
        paused: _paused,
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
  final ChallengeConfig challenge;
  final ValueListenable<bool>? paused;

  const GameWidget(
      {super.key,
      required this.row,
      required this.newNum,
      this.challenge = const ChallengeConfig.classic(),
      this.paused});

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
  bool _isFinished = false;
  bool _objectiveWon = false;
  int _moves = 0;
  int _elapsedSeconds = 0;
  Timer? _timer;
  final _store = ProgressStore();
  ToolKind? _selectedTool;
  int _doubleUses = 2;
  int _hammerUses = 2;
  int _bombUses = 1;
  int _shuffleVersion = 0;

  @override
  void initState() {
    super.initState();

    row = widget.row;
    column = widget.row;
    newNum = widget.newNum;

    cellPadding = BoardConfig.cellPadding(row);
    shadowOffset = BoardConfig.shadowOffset(row);

    _game = Game(row, column, newNum,
        seed: widget.challenge.seed, goldenEnabled: widget.challenge.hasGolden);
    _game.init();
    _restoreGame();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void newGame() {
    _game.init();
    _isGameOver = false;
    _isFinished = false;
    _objectiveWon = false;
    _moves = 0;
    _elapsedSeconds = 0;
    _selectedTool = null;
    _doubleUses = 2;
    _hammerUses = 2;
    _bombUses = 1;
    _store.clearSave();
    setState(() {});
  }

  void moveLeft() {
    _performMove(_game.moveLeft);
  }

  void moveRight() {
    _performMove(_game.moveRight);
  }

  void moveUp() {
    _performMove(_game.moveUp);
  }

  void moveDown() {
    _performMove(_game.moveDown);
  }

  void _performMove(bool Function() move) {
    if (_isFinished) return;
    final previousScore = _game.score;
    final previousGolden = _game.goldenHighest;
    if (!move()) return;
    HapticFeedback.selectionClick();
    _moves++;
    if (_game.goldenHighest > previousGolden) {
      GameAudioService.instance.playEffect(GameSound.golden);
    } else if (_game.score > previousScore) {
      GameAudioService.instance.playEffect(GameSound.merge);
    } else {
      GameAudioService.instance.playEffect(GameSound.move);
    }
    _saveGame();
    _evaluateGame();
    setState(() {});
  }

  void _evaluateGame() {
    if (_goalMet) {
      _finish(won: true);
      return;
    }
    if (widget.challenge.moveLimit != null &&
        _moves >= widget.challenge.moveLimit!) {
      _finish(won: false);
      return;
    }
    if (_game.isGameOver()) {
      if (widget.challenge.kind == ChallengeKind.zen) {
        _game.reviveZen();
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(S.of(context).Zen_Revived)));
        }
        return;
      }
      HapticFeedback.heavyImpact();
      setState(() => _isGameOver = true);
      _finish(won: false);
    }
  }

  void _tick() {
    if (!mounted || _isFinished || (widget.paused?.value ?? false)) return;
    _elapsedSeconds++;
    final limit = widget.challenge.seconds;
    if (limit != null && _elapsedSeconds >= limit) {
      _finish(won: _goalMet);
    }
    setState(() {});
  }

  Future<void> _finish({required bool won}) async {
    if (_isFinished) return;
    _isFinished = true;
    _isGameOver = true;
    _objectiveWon = won;
    await _store.clearSave();
    await _store.record(
        mode: widget.challenge.id,
        score: _game.score,
        moves: _moves,
        highestTile: _game.highestTile,
        seconds: _elapsedSeconds,
        completed: won,
        level: widget.challenge.level);
    final stats = await _store.stats();
    await GameCenterService().submit(
        mode: widget.challenge.id,
        score: _game.score,
        highestTile: _game.highestTile,
        moves: _moves,
        streak: stats['dailyStreak'] as int? ?? 0);
    if (mounted) setState(() {});
  }

  bool get _goalMet => switch (widget.challenge.goal) {
        ChallengeGoal.endless => false,
        ChallengeGoal.score =>
          _game.score >= (widget.challenge.targetScore ?? 1 << 30),
        ChallengeGoal.tile =>
          _game.highestTile >= (widget.challenge.targetTile ?? 1 << 30),
        ChallengeGoal.timedScore => widget.challenge.targetScore != null &&
            _game.score >= widget.challenge.targetScore!,
        ChallengeGoal.moveScore => widget.challenge.targetScore == null
            ? widget.challenge.moveLimit != null &&
                _moves >= widget.challenge.moveLimit!
            : _game.score >= widget.challenge.targetScore!,
        ChallengeGoal.goldenTile =>
          _game.goldenHighest >= (widget.challenge.goldenTarget ?? 1 << 30),
      };

  Future<void> _saveGame() => _store.save({
        'mode': widget.challenge.id,
        'moves': _moves,
        'elapsed': _elapsedSeconds,
        'doubleUses': _doubleUses,
        'hammerUses': _hammerUses,
        'bombUses': _bombUses,
        'game': _game.toJson(),
      });

  Future<void> _restoreGame() async {
    final saved = await _store.load();
    if (!mounted || saved?['mode'] != widget.challenge.id) return;
    final game = saved!['game'] as Map<String, dynamic>;
    if (game['row'] != row || game['newNum'] != newNum) return;
    _game.restore(game);
    _moves = saved['moves'] as int? ?? 0;
    _elapsedSeconds = saved['elapsed'] as int? ?? 0;
    _doubleUses = saved['doubleUses'] as int? ?? 2;
    _hammerUses = saved['hammerUses'] as int? ?? 2;
    _bombUses = saved['bombUses'] as int? ?? 1;
    setState(() {});
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
        final showsGoal = widget.challenge.kind != ChallengeKind.classic &&
            widget.challenge.kind != ChallengeKind.zen;
        final height =
            max(150.0, constraints.maxHeight - (showsGoal ? 300 : 250));
        _boardExtent = min(width, height).clamp(150.0, 580.0);
        return Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _metric(context, S.of(context).Score, '${_game.score}'),
                  _metric(
                      context,
                      S.of(context).Moves,
                      widget.challenge.moveLimit == null
                          ? '$_moves'
                          : '$_moves/${widget.challenge.moveLimit}'),
                  _metric(context, S.of(context).Time, _timeLabel),
                ]),
          ),
          if (showsGoal)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: widget.challenge.hasGolden
                    ? const Color(0xffFFD75E).withValues(alpha: .22)
                    : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadii.control),
                border: widget.challenge.hasGolden
                    ? Border.all(color: const Color(0xffD39C00))
                    : null,
              ),
              child: Row(children: [
                Icon(widget.challenge.hasGolden
                    ? Icons.auto_awesome_rounded
                    : Icons.flag_rounded),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                    child: Text(
                        widget.challenge.localizedObjective(S.of(context)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w900))),
              ]),
            ),
          Expanded(
              child: Center(
                  child: SizedBox.square(
            dimension: _boardExtent,
            child: TweenAnimationBuilder<double>(
              key: ValueKey(_shuffleVersion),
              tween: Tween(begin: 0, end: 1),
              duration: _shuffleVersion == 0
                  ? Duration.zero
                  : const Duration(milliseconds: 520),
              curve: Curves.easeInOutCubic,
              builder: (context, value, child) => Transform.rotate(
                angle: sin(value * pi * 4) * .025 * (1 - value),
                child: Transform.scale(
                    scale: 1 - sin(value * pi).abs() * .035, child: child),
              ),
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
                    _shuffleVersion++;
                    GameAudioService.instance.playEffect(GameSound.move);
                    _saveGame();
                    setState(() {});
                  }),
              GameActionButton(
                  icon: Icons.refresh_rounded,
                  label: S.of(context).Restart,
                  onPressed: newGame),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Row(children: [
              GameActionButton(
                  icon: Icons.exposure_plus_2_rounded,
                  label: '${S.of(context).Double_Tool} · $_doubleUses',
                  selected: _selectedTool == ToolKind.doubleTile,
                  onPressed: () => _selectTool(ToolKind.doubleTile)),
              GameActionButton(
                  icon: Icons.hardware_rounded,
                  label: '${S.of(context).Hammer_Tool} · $_hammerUses',
                  selected: _selectedTool == ToolKind.hammer,
                  onPressed: () => _selectTool(ToolKind.hammer)),
              GameActionButton(
                  icon: Icons.blur_circular_rounded,
                  label: '${S.of(context).Bomb_Tool} · $_bombUses',
                  selected: _selectedTool == ToolKind.bomb,
                  onPressed: () => _selectTool(ToolKind.bomb)),
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
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _useTool(r, c),
              child: GameTile(
                cell: cell,
                tileSize: tileSize,
                shadowOffset: shadowOffset,
              ),
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
        moves: _moves,
        highestTile: _game.highestTile,
        title: _resultTitle,
        message: widget.challenge.goal == ChallengeGoal.endless
            ? null
            : widget.challenge.localizedObjective(S.of(context)),
        onShare: _shareResult,
        onRestart: newGame,
      ));
    }
    return children;
  }

  Widget _metric(BuildContext context, String label, String value) =>
      Column(mainAxisSize: MainAxisSize.min, children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w900)),
      ]);

  String get _timeLabel {
    final seconds = widget.challenge.seconds == null
        ? _elapsedSeconds
        : max(0, widget.challenge.seconds! - _elapsedSeconds);
    return '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  String get _resultTitle {
    if (_objectiveWon) {
      return widget.challenge.kind == ChallengeKind.level
          ? S.of(context).Level_Complete
          : S.of(context).Challenge_Won;
    }
    if (widget.challenge.kind == ChallengeKind.level ||
        widget.challenge.kind == ChallengeKind.objective) {
      return S.of(context).Challenge_Failed;
    }
    if (widget.challenge.kind == ChallengeKind.sprint) {
      return S.of(context).Time_Up;
    }
    if (widget.challenge.moveLimit != null &&
        _moves >= widget.challenge.moveLimit!) {
      return S.of(context).Challenge_Complete;
    }
    return S.of(context).Game_Over;
  }

  void _shareResult() {
    final box = context.findRenderObject() as RenderBox?;
    SharePlus.instance.share(ShareParams(
      text: S.of(context).Share_Message(
          _game.score,
          widget.challenge.localizedTitle(S.of(context)),
          _moves,
          _game.highestTile),
      sharePositionOrigin:
          box == null ? null : box.localToGlobal(Offset.zero) & box.size,
    ));
  }

  void _drag(Offset delta, {bool vertical = false}) {
    if (delta.distance == 0 || _isDragging) return;
    _isDragging = true;
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

  void _selectTool(ToolKind tool) {
    if (_isFinished) return;
    final uses = switch (tool) {
      ToolKind.doubleTile => _doubleUses,
      ToolKind.hammer => _hammerUses,
      ToolKind.bomb => _bombUses,
    };
    if (uses <= 0) {
      GameAudioService.instance.playEffect(GameSound.error);
      return;
    }
    _selectedTool = tool;
    GameAudioService.instance.playEffect(GameSound.select);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(S.of(context).Select_Tile(_toolName(tool)))));
    setState(() {});
  }

  void _useTool(int r, int c) {
    final tool = _selectedTool;
    if (tool == null || _isFinished) return;
    final success = switch (tool) {
      ToolKind.doubleTile => _game.doubleCell(r, c),
      ToolKind.hammer => _game.hammerCell(r, c),
      ToolKind.bomb => _game.bombCell(r, c),
    };
    if (!success) {
      GameAudioService.instance.playEffect(GameSound.error);
      return;
    }
    switch (tool) {
      case ToolKind.doubleTile:
        _doubleUses--;
      case ToolKind.hammer:
        _hammerUses--;
      case ToolKind.bomb:
        _bombUses--;
    }
    _selectedTool = null;
    GameAudioService.instance.playEffect(GameSound.tool);
    _saveGame();
    _evaluateGame();
    setState(() {});
  }

  String _toolName(ToolKind tool) => switch (tool) {
        ToolKind.doubleTile => S.of(context).Double_Tool,
        ToolKind.hammer => S.of(context).Hammer_Tool,
        ToolKind.bomb => S.of(context).Bomb_Tool,
      };

  Size boardSize() {
    return Size.square(_boardExtent);
  }
}

enum ToolKind { doubleTile, hammer, bomb }

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

class _GameTileState extends State<GameTile> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _goldController;
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
    _goldController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    if (widget.cell.isGolden) _goldController.repeat();

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
    if (widget.cell.isGolden && !_goldController.isAnimating) {
      _goldController.repeat();
    } else if (!widget.cell.isGolden && _goldController.isAnimating) {
      _goldController.stop();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _goldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final number = widget.cell.number;
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnim, _goldController]),
      builder: (context, _) => Transform.scale(
          scale: _scaleAnim.value *
              (widget.cell.isGolden
                  ? 1 + sin(_goldController.value * pi * 2) * .025
                  : 1),
          child: CellBox(
            left: 0,
            top: 0,
            size: widget.tileSize,
            color: tileColor(number),
            shadowOffset: widget.shadowOffset,
            isGolden: widget.cell.isGolden,
            goldenProgress: _goldController.value,
            text: Text(
              number.toString(),
              maxLines: 1,
              style: tileTextStyle(context, number),
            ),
          )),
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
  final bool isGolden;
  final double goldenProgress;

  const CellBox({
    super.key,
    required this.left,
    required this.top,
    required this.size,
    required this.color,
    required this.shadowOffset,
    required this.text,
    this.isGolden = false,
    this.goldenProgress = 0,
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
                color: isGolden ? null : color,
                gradient: isGolden
                    ? LinearGradient(
                        begin: Alignment(-1 + goldenProgress * 2, -1),
                        end: Alignment(1 + goldenProgress * 2, 1),
                        colors: const [
                          Color(0xffB97800),
                          Color(0xffFFF1A6),
                          Color(0xffFFD447),
                          Color(0xff9D5B00),
                        ],
                      )
                    : null,
                borderRadius: AppRadii.tile,
                boxShadow: [
                  if (isGolden)
                    BoxShadow(
                      color: const Color(0xffFFD447)
                          .withValues(alpha: .55 + goldenProgress * .2),
                      blurRadius: 12 + goldenProgress * 8,
                      spreadRadius: 1,
                    ),
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
              child: Stack(children: [
                Center(
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: text)),
                if (isGolden)
                  const Positioned(
                      right: 3,
                      top: 3,
                      child: Icon(Icons.auto_awesome_rounded,
                          size: 14, color: Color(0xff6A3B00))),
              ]),
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
  final int moves;
  final int highestTile;
  final String title;
  final String? message;
  final VoidCallback onRestart;
  final VoidCallback? onShare;

  const GameOverOverlay({
    super.key,
    required this.score,
    this.moves = 0,
    this.highestTile = 0,
    this.title = 'Game Over',
    this.message,
    required this.onRestart,
    this.onShare,
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
                Text(title,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.onInverseSurface)),
                const SizedBox(height: 12),
                Text('${S.of(context).Score}: $score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onInverseSurface)),
                const SizedBox(height: 16),
                Text(S.of(context).Highest_Tile_Result(moves, highestTile),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onInverseSurface)),
                const SizedBox(height: 16),
                Text(message ?? S.of(context).Game_Over_Message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onInverseSurface)),
                const SizedBox(height: 28),
                PauseButton(
                  text: S.of(context).Restart,
                  onPressed: onRestart,
                ),
                if (onShare != null)
                  TextButton.icon(
                      onPressed: onShare,
                      icon: const Icon(Icons.share_rounded),
                      label: Text(S.of(context).Share_Result)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
