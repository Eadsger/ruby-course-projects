# spec/tic_tac_toe_spec.rb
require_relative '../lib/tic_tac_toe' # Assuming your TicTacToe class is in the same directory

RSpec.describe TicTacToe do
  let(:game) { TicTacToe.new }

  describe '#valid_move?' do
    it 'returns true for valid moves' do
      expect(game.valid_move?(0, 0)).to be(true)
    end

    it 'returns false for out-of-bounds moves' do
      expect(game.valid_move?(-1, 1)).to be(false)
    end
  end

  describe '#make_move' do
    it 'updates the board with a valid move' do
      game.make_move(0, 0)
      expect(game.instance_variable_get(:@board)[0][0]).to eq('X')
    end

    it 'does not update the board for an invalid move' do
      game.make_move(3, 3)
      expect(game.instance_variable_get(:@board)).to eq(Array.new(3) { Array.new(3, ' ') })
    end
  end

  describe '#winner?' do
    context 'when there is a winner' do
      it 'returns true for a winning column' do
        game.instance_variable_set(:@board, [['X', ' ', ' '], ['X', ' ', ' '], ['X', ' ', ' ']])
        expect(game.winner?).to be(true)
      end

      it 'returns true for a winning diagonal' do
        game.instance_variable_set(:@board, [['X', ' ', 'O'], [' ', 'X', 'O'], ['O', ' ', 'X']])
        expect(game.winner?).to be(true)
      end
    end

    context 'when there is no winner' do
      it 'returns false' do
        expect(game.winner?).to be(false)
      end
    end
  end

  describe '#board_full?' do
    context 'when the board is full' do
      it 'returns true' do
        game.instance_variable_set(:@board, [['X', 'O', 'X'], ['O', 'X', 'O'], ['X', 'O', 'X']])
        expect(game.board_full?).to be(true)
      end
    end

    context 'when the board is not full' do
      it 'returns false' do
        expect(game.board_full?).to be(false)
      end
    end
  end

  describe '#game_over?' do
    context 'when there is a winner' do
      it 'returns true' do
        allow(game).to receive(:winner?).and_return(true)
        expect(game.game_over?).to be(true)
      end
    end

    context 'when the board is full but there is no winner' do
      it 'returns true' do
        allow(game).to receive(:winner?).and_return(false)
        allow(game).to receive(:board_full?).and_return(true)
        expect(game.game_over?).to be(true)
      end
    end

    context 'when there is no winner and the board is not full' do
      it 'returns false' do
        allow(game).to receive(:winner?).and_return(false)
        allow(game).to receive(:board_full?).and_return(false)
        expect(game.game_over?).to be(false)
      end
    end
  end
end
