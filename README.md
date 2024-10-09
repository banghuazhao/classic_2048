# 🎮 Classic 2048 Game

## 📝 Overview

Classic 2048 is a mobile puzzle game inspired by the original 2048 game developed using Flutter. The objective is to slide numbered tiles on a grid to combine them and create a tile with the number 2048.

[Available on Google Play](https://play.google.com/store/apps/details?id=com.appsbay.classic_2048)

## 🌟 Features

- 📐 **Multiple Grid Sizes**: Choose from 4x4, 5x5, and 6x6 grids for different levels of difficulty.
- 🎲 **Random and Shuffle Options**: Mix up the tiles with Random and Shuffle buttons to add an extra challenge.
- 🖼️ **Beautiful Backgrounds**: Enjoy stunning background images as you play, inspired by nature and scenic locations.
- 💫 **Smooth Animations**: Experience smooth and fluid animations that enhance gameplay.
- 👤 **User-friendly Interface**: Simple and intuitive UI design for an engaging user experience.


## Screenshots

<p align="center">
<img src="./images/game_mode.webp" alt="iOS Screenshot" width="200">
<img src="./images/game_play.webp" alt="iOS Screenshot" width="200">
</p>

## 🔧 Version Constraints

- **Dart**: `>=3.0.0 <4.0.0`
- **Flutter**: `>=3.10.0`

## 🎮 How to Play

1. **Choose Game Mode**: Select your preferred grid size.
2. **Slide to Play**: Swipe in any direction to move the tiles. When two tiles with the same number touch, they merge into one.
3. **Aim for 2048**: Keep merging tiles until you create a tile with the number 2048.
4. **Use Shuffle and Random**: If you're stuck, use the Shuffle or Random buttons to mix up the board.

## 🧩 Game Logic

The main game mechanics for Classic 2048 are implemented in the `Game` class, which controls the board's state, score, and tile movements. Here’s an overview of the core functions:

- **`init()`**: Initializes the game board with empty cells, sets the score to zero, and places the starting tiles.
- **`moveLeft()`, `moveRight()`, `moveUp()`, `moveDown()`**: Handles the movement of tiles in each respective direction. These methods merge tiles of the same value and shift them appropriately to create new tiles.
- **`canMoveLeft()`, `canMoveRight()`, `canMoveUp()`, `canMoveDown()`**: Checks if a move in the specified direction is possible by identifying mergeable or empty adjacent cells.
- **`mergeLeft()`, `mergeRight()`, `mergeUp()`, `mergeDown()`**: Merges tiles as they shift, combining them if they have the same value and are adjacent, then updates the score.
- **`randomEmptyCell(int cnt)`**: Randomly places a new tile (2 or 4) on an empty cell after a move. The probability of spawning a 4 is set to 1/15.
- **`isGameOver()`**: Determines if there are no possible moves left, indicating the game is over.
- **`shuffle()`**: Randomizes the tiles on the board, adding an extra layer of challenge for players.
- **`resetMergeStatus()`**: Resets the merge status of all cells on the board, preparing for the next move.

The **`BoardCell`** class represents each tile on the grid, tracking its position, value, and whether it has recently merged. Together, these functions and classes enable smooth gameplay with responsive tile merging, movement, and scoring.


## 🤝 Contribution

Feel free to fork this repository and submit pull requests. For major changes, please open an issue first to discuss what you would like to change.

## 📄 License

This project is licensed under the MIT [License](LICENSE).