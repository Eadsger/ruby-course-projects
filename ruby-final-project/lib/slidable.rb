module Slidable
  def available_moves
    moves = []

    move_directions.each do |row_dir, column_dir|
      current_row, current_column = location

      loop do
        current_row += row_dir
        current_column += column_dir
        loc = [current_row, current_column]
        break if !board.in_bounds?(loc)

        if board.empty?(loc)
          moves << loc
        end
        if enemy?(loc)
          moves << loc
          break
        end
      end
    end
    moves
  end
end
