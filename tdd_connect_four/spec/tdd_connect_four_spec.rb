require 'tdd_connect_four'

RSpec.describe ConnectFour do
  let(:game) { ConnectFour.new }

  describe '#initialize' do
    it 'creates a 6x7 empty board' do
      expect(game.board.length).to eq(6)
      expect(game.board.all? { |row| row.length == 7 && row.all?(' ') }).to be true
    end
  end

  describe '#drop_piece' do
    context 'when dropping a piece in an empty column' do
      it 'places the piece at the bottom of the column' do
        game.drop_piece(2, 'X')
        expect(game.board[5][2]).to eq('X')
      end
    end

    context 'when dropping a piece in a non-empty column' do
      it 'places the piece on top of the existing pieces' do
        game.drop_piece(3, 'O')
        game.drop_piece(3, 'X')
        expect(game.board[5][3]).to eq('O')  # Corrected this line
        expect(game.board[4][3]).to eq('X')
      end
    end

    context 'when dropping a piece in a full column' do
      it 'raises an error' do
        6.times { game.drop_piece(4, 'O') }
        expect { game.drop_piece(4, 'X') }.to raise_error('Column is full')
      end
    end
  end

  describe '#display_board' do
    it 'prints the current state of the board' do
    expect { game.display_board }.to output(/.*\|.*\|.*\|.*\|.*\|.*\|.*\n/).to_stdout
  end

  describe '#valid_move?' do
    it 'returns true for a valid move' do
      expect(game.send(:valid_move?, 3)).to be true
    end

    it 'returns false for an invalid move (out of bounds)' do
      expect(game.send(:valid_move?, -1)).to be false
      expect(game.send(:valid_move?, 7)).to be false
    end

    it 'returns false for an invalid move (full column)' do
      6.times { game.drop_piece(3, 'X') } # Fill column 3
      expect(game.send(:valid_move?, 3)).to be false
    end
  end
end
end
