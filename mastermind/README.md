# Mastermind Game

This is a simple implementation of the Mastermind game in Ruby for the command line.

## Game Rules

- The secret code consists of four colors chosen from the set: R, G, B, Y, O, P.
- The player has 12 turns to guess the secret code.
- After each guess, the game provides feedback on the number of exact matches and color matches.

## Gameplay Options

### Code Maker (M)

If you choose to be the code maker, you will input the secret code, and the computer will try to guess it.

### Code Breaker (B)

If you choose to be the code breaker, the computer will generate a secret code, and you will try to guess it.

## Code Examples

### Guessing as Code Breaker

When guessing as the code breaker, you will input your guesses following the format (e.g., RGBY).

    ```bash
    Do you want to be the code maker (enter 'M') or code breaker (enter 'B')? B
    Welcome to Mastermind!

    Secret code: RYBG
    Enter your guess (e.g., RGBY): RGBO
    ```

### Setting the Code as Code Maker

When setting the code as the code maker, you will input your secret code following the format (e.g., RGBY).

    ```bash
    Do you want to be the code maker (enter 'M') or code breaker (enter 'B')? M
    Enter your secret code (e.g., RGBY): GBPO
    Welcome to Mastermind!

    Turn 1: RYBG   Exact Matches: 0   Color Matches: 2
    ```
