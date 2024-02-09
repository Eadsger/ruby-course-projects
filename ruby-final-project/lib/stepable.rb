module Stepable
  def available_moves
    moves = []

    move_directions.each do |row_dir, column_dir|
      current_row, current_column = location

      current_row += row_dir
      current_column += column_dir
      loc = [current_row, current_column]
      next if !board.in_bounds?(loc)

      if board.empty?(loc) || enemy?(loc)
        moves << loc
      end
    end
    moves
  end
end
