class BoardRendererText
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def render
    8.times do |row|
      puts "---------------"
      8.times do |column|
        piece = board[[row, column]]
        if piece.nil?
          print "  "
        else
          print "#{board[[row, column]]} "
        end
      end
      puts ""
    end
    puts "---------------"
  end
end
