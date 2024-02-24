# Ruby Chess Game

This is a simple command-line chess game implemented in Ruby. It allows two players to play a game of chess by entering moves using algebraic notation.

## Features
- Classic chess gameplay with standard rules.
- Support for moves including regular moves, captures, castling, and pawn promotion.
- Complete move validation to ensure only legal moves are allowed.
- Ability to detect checkmate, stalemate, and check conditions to determine game outcomes.
- User-friendly interface with prompts for moves and piece promotions.

## Requirements
- Ruby interpreter installed (developed and tested on Ruby 2.7.2)
- Command-line environment (e.g., Terminal on macOS, Command Prompt or PowerShell on Windows, or any terminal emulator on Linux)

## How to Play
1. Each player takes turns to make a move by specifying the source and destination squares of the piece they want to move.
2. Moves are entered using algebraic notation (e.g., "e2 e4" to move a pawn from e2 to e4).
3. If a pawn reaches the opposite end of the board, the player will be prompted to choose a piece for promotion (queen, rook, knight, or bishop).