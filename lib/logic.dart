import 'dart:math' show Random;

class Game {
  final int row;
  final int column;
  final int newNum;
  int score = 0;
  final bool goldenEnabled;
  int goldenHighest = 0;

  final Random _random;
  Game(this.row, this.column, this.newNum,
      {int? seed, this.goldenEnabled = false})
      : _random = Random(seed);

  late List<List<BoardCell>> _boardCells;

  void init() {
    _boardCells = <List<BoardCell>>[];
    for (int r = 0; r < row; ++r) {
      _boardCells.add(<BoardCell>[]);
      for (int c = 0; c < column; ++c) {
        _boardCells[r].add(BoardCell(
          row: r,
          column: c,
          number: 0,
          isNew: false,
        ));
      }
    }
    score = 0;
    goldenHighest = 0;
    resetMergeStatus();
    randomEmptyCell(2);
    if (goldenEnabled) _assignGoldenTile();
  }

  BoardCell get(int r, int c) {
    return _boardCells[r][c];
  }

  bool moveLeft() {
    if (!canMoveLeft()) {
      return false;
    }
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        mergeLeft(r, c);
      }
    }
    randomEmptyCell(newNum);
    resetMergeStatus();
    return true;
  }

  bool moveRight() {
    if (!canMoveRight()) {
      return false;
    }
    for (int r = 0; r < row; ++r) {
      for (int c = column - 2; c >= 0; --c) {
        mergeRight(r, c);
      }
    }
    randomEmptyCell(newNum);
    resetMergeStatus();
    return true;
  }

  bool moveUp() {
    if (!canMoveUp()) {
      return false;
    }
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        mergeUp(r, c);
      }
    }
    randomEmptyCell(newNum);
    resetMergeStatus();
    return true;
  }

  bool moveDown() {
    if (!canMoveDown()) {
      return false;
    }
    for (int r = row - 2; r >= 0; --r) {
      for (int c = 0; c < column; ++c) {
        mergeDown(r, c);
      }
    }
    randomEmptyCell(newNum);
    resetMergeStatus();
    return true;
  }

  void shuffle() {
    List<BoardCell> arr = [];

    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        BoardCell newBoardCell = BoardCell(
            row: r,
            column: c,
            number: _boardCells[r][c].number,
            isNew: _boardCells[r][c].isNew);
        newBoardCell.id = _boardCells[r][c].id;
        newBoardCell.isGolden = _boardCells[r][c].isGolden;
        newBoardCell.isMerged = _boardCells[r][c].isMerged;
        arr.add(newBoardCell);
      }
    }

    arr.shuffle();

    int i = 0;
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        _boardCells[r][c].number = arr[i].number;
        _boardCells[r][c].id = arr[i].id;
        _boardCells[r][c].isGolden = arr[i].isGolden;
        _boardCells[r][c].isMerged = false;
        _boardCells[r][c].isNew = false;
        i = i + 1;
      }
    }
  }

  bool canMoveLeft() {
    for (int r = 0; r < row; ++r) {
      for (int c = 1; c < column; ++c) {
        if (canMerge(_boardCells[r][c], _boardCells[r][c - 1])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMoveRight() {
    for (int r = 0; r < row; ++r) {
      for (int c = column - 2; c >= 0; --c) {
        if (canMerge(_boardCells[r][c], _boardCells[r][c + 1])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMoveUp() {
    for (int r = 1; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        if (canMerge(_boardCells[r][c], _boardCells[r - 1][c])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMoveDown() {
    for (int r = row - 2; r >= 0; --r) {
      for (int c = 0; c < column; ++c) {
        if (canMerge(_boardCells[r][c], _boardCells[r + 1][c])) {
          return true;
        }
      }
    }
    return false;
  }

  void mergeLeft(int r, int c) {
    while (c > 0) {
      merge(_boardCells[r][c], _boardCells[r][c - 1]);
      c--;
    }
  }

  void mergeRight(int r, int c) {
    while (c < column - 1) {
      merge(_boardCells[r][c], _boardCells[r][c + 1]);
      c++;
    }
  }

  void mergeUp(int r, int c) {
    while (r > 0) {
      merge(_boardCells[r][c], _boardCells[r - 1][c]);
      r--;
    }
  }

  void mergeDown(int r, int c) {
    while (r < row - 1) {
      merge(_boardCells[r][c], _boardCells[r + 1][c]);
      r++;
    }
  }

  bool canMerge(BoardCell a, BoardCell b) {
    return !b.isMerged &&
        ((b.isEmpty() && !a.isEmpty()) ||
            (!a.isEmpty() &&
                !b.isEmpty() &&
                (a == b || a.isGolden || b.isGolden)));
  }

  void merge(BoardCell a, BoardCell b) {
    if (!canMerge(a, b)) {
      if (!a.isEmpty() && !b.isMerged) {
        b.isMerged = true;
      }
      return;
    }

    if (b.isEmpty()) {
      b.number = a.number;
      b.id = a.id;
      b.isGolden = a.isGolden;
      a.number = 0;
      a.isGolden = false;
      a.id = BoardCell._nextId++;
    } else if (a == b || a.isGolden || b.isGolden) {
      final goldenMerge = a.isGolden || b.isGolden;
      b.number = goldenMerge
          ? (a.number > b.number ? a.number : b.number) * 3
          : b.number * 2;
      a.number = 0;
      a.isGolden = false;
      a.id = BoardCell._nextId++;
      score += b.number;
      b.isGolden = goldenMerge;
      if (goldenMerge && b.number > goldenHighest) goldenHighest = b.number;
      b.isMerged = true;
      b.isNew = true;
      b.id = BoardCell._nextId++;
    } else {
      b.isMerged = true;
    }
  }

  bool isGameOver() {
    return !canMoveLeft() && !canMoveRight() && !canMoveUp() && !canMoveDown();
  }

  void randomEmptyCell(int cnt) {
    List<BoardCell> emptyCells = <BoardCell>[];
    _boardCells.forEach((cells) {
      emptyCells.addAll(cells.where((cell) {
        return cell.isEmpty();
      }));
    });
    if (emptyCells.isEmpty) {
      return;
    }
    for (int i = 0; i < cnt && emptyCells.isNotEmpty; i++) {
      int index = _random.nextInt(emptyCells.length);
      emptyCells[index].number = randomCellNum();
      emptyCells[index].isNew = true;
      emptyCells.removeAt(index);
    }
  }

  // 随机单元数字，出现4的概率为1/15
  int randomCellNum() {
    return _random.nextInt(15) == 0 ? 4 : 2;
  }

  void _assignGoldenTile() {
    final occupied = _boardCells
        .expand((cells) => cells)
        .where((cell) => !cell.isEmpty())
        .toList();
    if (occupied.isEmpty || occupied.any((cell) => cell.isGolden)) return;
    final cell = occupied[_random.nextInt(occupied.length)];
    cell.isGolden = true;
    cell.isNew = true;
  }

  bool doubleCell(int r, int c) {
    final cell = get(r, c);
    if (cell.isEmpty()) return false;
    cell.number *= 2;
    cell.id = BoardCell._nextId++;
    cell.isNew = true;
    return true;
  }

  bool hammerCell(int r, int c) {
    final cell = get(r, c);
    if (cell.isEmpty()) return false;
    cell.number = 0;
    cell.isGolden = false;
    cell.id = BoardCell._nextId++;
    if (goldenEnabled) _assignGoldenTile();
    return true;
  }

  bool bombCell(int centerRow, int centerColumn) {
    var total = 0;
    var containsGolden = false;
    for (var r = centerRow - 1; r <= centerRow + 1; r++) {
      for (var c = centerColumn - 1; c <= centerColumn + 1; c++) {
        if (r < 0 || r >= row || c < 0 || c >= column) continue;
        final cell = get(r, c);
        total += cell.number;
        containsGolden = containsGolden || cell.isGolden;
        cell.number = 0;
        cell.isGolden = false;
        cell.id = BoardCell._nextId++;
      }
    }
    if (total == 0) return false;
    final target = get(centerRow, centerColumn);
    target.number = total;
    target.isGolden = containsGolden;
    target.isNew = true;
    target.id = BoardCell._nextId++;
    score += total;
    if (goldenEnabled) _assignGoldenTile();
    return true;
  }

  void reviveZen() {
    final occupied = _boardCells
        .expand((cells) => cells)
        .where((cell) => !cell.isEmpty())
        .toList()
      ..sort((a, b) => a.number.compareTo(b.number));
    final removeCount = (occupied.length / 4).ceil();
    for (final cell in occupied.take(removeCount)) {
      cell.number = 0;
      cell.isGolden = false;
      cell.id = BoardCell._nextId++;
    }
    randomEmptyCell(1);
    if (goldenEnabled) _assignGoldenTile();
  }

  void resetMergeStatus() {
    _boardCells.forEach((cells) {
      cells.forEach((cell) {
        cell.isMerged = false;
      });
    });
  }

  int get highestTile => _boardCells.expand((row) => row).fold(
      0, (highest, cell) => cell.number > highest ? cell.number : highest);

  Map<String, dynamic> toJson() => {
        'row': row,
        'column': column,
        'newNum': newNum,
        'score': score,
        'goldenHighest': goldenHighest,
        'board': _boardCells
            .map((cells) => cells
                .map((cell) => {
                      'number': cell.number,
                      'golden': cell.isGolden,
                    })
                .toList())
            .toList(),
      };

  void restore(Map<String, dynamic> json) {
    final board = json['board'] as List<dynamic>;
    for (var r = 0; r < row; r++) {
      final values = board[r] as List<dynamic>;
      for (var c = 0; c < column; c++) {
        final value = values[c];
        if (value is Map<String, dynamic>) {
          _boardCells[r][c].number = value['number'] as int;
          _boardCells[r][c].isGolden = value['golden'] as bool? ?? false;
        } else {
          _boardCells[r][c].number = value as int;
          _boardCells[r][c].isGolden = false;
        }
        _boardCells[r][c].isNew = false;
      }
    }
    score = json['score'] as int? ?? 0;
    goldenHighest = json['goldenHighest'] as int? ?? 0;
    resetMergeStatus();
  }
}

class BoardCell {
  static int _nextId = 1;

  int id;
  int row, column;
  int number = 0;
  bool isMerged = false;
  bool isNew = false;
  bool isGolden = false;

  BoardCell(
      {required this.row,
      required this.column,
      required this.number,
      required this.isNew})
      : id = _nextId++;

  bool isEmpty() {
    return number == 0;
  }

  @override
  int get hashCode {
    return number.hashCode;
  }

  @override
  bool operator ==(other) {
    return other is BoardCell && number == other.number;
  }
}
