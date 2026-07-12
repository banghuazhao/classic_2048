import 'dart:math' show Random;

class Game {
  final int row;
  final int column;
  final int newNum;
  int score = 0;

  final Random _random;
  Game(this.row, this.column, this.newNum, {int? seed})
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
    resetMergeStatus();
    randomEmptyCell(2);
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
        newBoardCell.isMerged = _boardCells[r][c].isMerged;
        arr.add(newBoardCell);
      }
    }

    arr.shuffle();

    int i = 0;
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        _boardCells[r][c].number = arr[i].number;
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
        ((b.isEmpty() && !a.isEmpty()) || (!a.isEmpty() && a == b));
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
      a.number = 0;
      a.id = BoardCell._nextId++;
    } else if (a == b) {
      b.number = b.number * 2;
      a.number = 0;
      a.id = BoardCell._nextId++;
      score += b.number;
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
        'board': _boardCells
            .map((cells) => cells.map((cell) => cell.number).toList())
            .toList(),
      };

  void restore(Map<String, dynamic> json) {
    final board = json['board'] as List<dynamic>;
    for (var r = 0; r < row; r++) {
      final values = board[r] as List<dynamic>;
      for (var c = 0; c < column; c++) {
        _boardCells[r][c].number = values[c] as int;
        _boardCells[r][c].isNew = false;
      }
    }
    score = json['score'] as int? ?? 0;
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
