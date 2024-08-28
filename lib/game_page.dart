import 'dart:math';

import 'package:classic_2048/game_pause_cover.dart';
import 'package:classic_2048/util/ads_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'generated/l10n.dart';
import 'logic.dart';
import 'main.dart';

class GamePage extends StatelessWidget {
  int row;
  int newNum;
  String bg;

  GamePage({Key? key, required this.row, required this.newNum, required this.bg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double safePadding = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;
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
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
              ),
            ),
            flexibleSpace: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => GamePauseCoverPage(bg: bg)));
              },
              child: Image(
                image: AssetImage('assets/image/$bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              // IconButton(
              //   icon: Icon(Icons.info_outline),
              //   onPressed: () {
              //     // return _aboutDialogAction(context);
              //   },
              // )
            ]),
      ),
      backgroundColor: Color(0xff47507C),
      body: GameWidget(
        row: row,
        newNum: newNum,
      ),
    );
  }
}

class BoardGridWidget extends StatelessWidget {
  final _GameWidgetState _state;
  BoardGridWidget(this._state);
  @override
  Widget build(BuildContext context) {
    final boardSize = _state.boardSize();
    double width =
        (boardSize.width - 20 - (_state.column + 1) * _state.cellPadding) / _state.column;
    List<CellBox> _backgroundBox = <CellBox>[];
    for (int r = 0; r < _state.row; ++r) {
      for (int c = 0; c < _state.column; ++c) {
        CellBox box = CellBox(
          left: c * width + _state.cellPadding * (c + 1),
          top: r * width + _state.cellPadding * (r + 1),
          size: width,
          shadowOffset: _state.shadowOffset,
          color: Colors.white.withOpacity(0.1),
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
            border: Border.all(color: Color(0xff34415F), width: 10),
            color: Color(0xff4C5B7D),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Stack(
            children: _backgroundBox,
          ),
        ));
  }
}

class GameWidget extends StatefulWidget {
  int row;
  int newNum;

  GameWidget({Key? key, required this.row, required this.newNum}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GameWidgetState();
  }
}

class _GameWidgetState extends State<GameWidget> {
  late BannerAd _ad;

  bool _isAdLoaded = false;

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

    super.initState();

    row = widget.row;
    column = widget.row;
    newNum = widget.newNum;

    if (widget.row == 4) {
      cellPadding = 15;
      shadowOffset = 2;
    } else if (widget.row == 5) {
      cellPadding = 10;
      shadowOffset = 1.5;
    } else {
      cellPadding = 8;
      shadowOffset = 1;
    }

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
      _isGameOver = true;
      Fluttertoast.showToast(
          msg: S.of(context).Game_Over,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
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
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
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
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            _game.score.toString(),
                            style: TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            height: 10.0,
          ),
          Container(
              margin: _gameMargin,
              width: _queryData.size.width - _gameMargin.left * 2,
              height: _queryData.size.width - _gameMargin.left * 2 + 10,
              child: GestureDetector(
                onVerticalDragUpdate: (detail) {
                  if (detail.delta.distance == 0 || _isDragging) {
                    return;
                  }
                  _isDragging = true;
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
                  if (detail.delta.distance == 0 || _isDragging) {
                    return;
                  }
                  _isDragging = true;
                  if (detail.delta.direction > 0) {
                    moveLeft();
                  } else {
                    moveRight();
                  }
                },
                onHorizontalDragDown: (detail) {
                  _isDragging = false;
                },
                onHorizontalDragCancel: () {
                  _isDragging = false;
                },
                child: Stack(
                  children: children,
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CupertinoButton(
                  padding: EdgeInsets.all(5),
                  onPressed: () {
                    var arr = [];
                    if (_game.canMoveDown()) {
                      arr.add(1);
                    }
                    if (_game.canMoveLeft()) {
                      arr.add(2);
                    }
                    if (_game.canMoveRight()) {
                      arr.add(3);
                    }
                    if (_game.canMoveUp()) {
                      arr.add(4);
                    }

                    arr.shuffle();

                    if (arr.length > 0) {
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
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.casino_outlined,
                        color: Color(0xffFF9C76),
                      ),
                      Text("Random", style: TextStyle(fontSize: 15, color: Color(0xffFF9C76))),
                    ],
                  )),
              CupertinoButton(
                  padding: EdgeInsets.all(5),
                  onPressed: () {
                    _game.shuffle();
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.shuffle_rounded,
                        color: Color(0xffFF9C76),
                      ),
                      Text("Shuffle", style: TextStyle(fontSize: 15, color: Color(0xffFF9C76))),
                    ],
                  )),
              CupertinoButton(
                  padding: EdgeInsets.all(5),
                  onPressed: () {
                    newGame();
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        color: Color(0xffFF9C76),
                      ),
                      Text("Restart", style: TextStyle(fontSize: 15, color: Color(0xffFF9C76))),
                    ],
                  )),
            ],
          ),
          // Spacer(),
          // if (_isAdLoaded)
          //   Container(
          //     margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
          //     child: AdWidget(ad: _ad),
          //     height: 50.0,
          //   ),
        ],
      ),
    );
  }

  Size boardSize() {
    assert(_queryData != null);
    Size size = _queryData.size;
    double width = size.width - _gameMargin.left - _gameMargin.right;
    return Size(width, width);
  }
}

class AnimatedCellWidget extends AnimatedWidget {
  final BoardCell cell;
  final _GameWidgetState state;
  AnimatedCellWidget(
      {Key? key, required this.cell, required this.state, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    double animationValue = animation.value;
    Size boardSize = state.boardSize();
    double width = (boardSize.width - 20 - (state.column + 1) * state.cellPadding) / state.column;
    var textColor = Colors.black.withOpacity(0.8);
    if ([4, 16, 64, 256, 1048].contains(cell.number)) {
      textColor = Colors.black.withOpacity(0.8);
    }
    if (cell.number == 0) {
      return Container();
    } else {
      return CellBox(
        left: (cell.column * width + 10 + state.cellPadding * (cell.column + 1)) +
            width / 2 * (1 - animationValue),
        top: cell.row * width +
            10 +
            state.cellPadding * (cell.row + 1) +
            width / 2 * (1 - animationValue),
        size: width * animationValue,
        color: BoxColors.containsKey(cell.number)
            ? BoxColors[cell.number]!
            : BoxColors[BoxColors.keys.last]!,
        shadowOffset: state.shadowOffset,
        text: Text(
          cell.number.toString(),
          maxLines: 1,
          style: TextStyle(
            fontSize: getFontSize(animationValue),
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
      );
    }
  }

  double getFontSize(double animationValue) {
    if (cell.number < 16) {
      return 40 * animationValue;
    } else if (cell.number < 128) {
      return 36 * animationValue;
    } else if (cell.number < 1024) {
      return 32 * animationValue;
    } else {
      return 28 * animationValue;
    }
  }
}

class CellWidget extends StatefulWidget {
  final BoardCell cell;
  final _GameWidgetState state;
  CellWidget({required this.cell, required this.state});
  _CellWidgetState createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
      vsync: this,
    );
    animation = new Tween(begin: 0.0, end: 1.0).animate(controller);
  }

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
  Text? text;
  CellBox(
      {required this.left,
      required this.top,
      required this.size,
      required this.color,
      required this.shadowOffset,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: color != Colors.white.withOpacity(0.1)
          ? Container(
              width: size,
              height: size,
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: shadowOffset * 2,
                      offset: Offset(-shadowOffset, -shadowOffset)),
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: shadowOffset * 2,
                      offset: Offset(shadowOffset, shadowOffset)),
                ],
              ),
              child: Center(
                  child:
                      FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.center, child: text)),
            )
          : Container(
              width: size,
              height: size,
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Center(
                  child:
                      FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.center, child: text)),
            ),
    );
  }
}
