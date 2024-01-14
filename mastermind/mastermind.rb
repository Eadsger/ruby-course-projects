class Mastermind
  COLORS = ['R', 'G', 'B', 'Y', 'O', 'P'].freeze
  MAX_TURNS = 12

  def initialize
    @secret_code = []
    @role = select_role
    @turn = 1
  end

  def play
    puts "Welcome to Mastermind!"
    puts "Here are the available colors for the code: #{COLORS}!"
    generate_secret_code if @role == :maker
    auto_generate_secret_code if @role == :breaker

    while @turn <= MAX_TURNS
      guess = @role == :breaker ? human_guess : computer_guess
      exact_matches, color_matches = evaluate_guess(guess)

      display_board(guess, exact_matches, color_matches)

      if exact_matches == 4
        puts "Congratulations! You guessed the correct code."
        return
      end

      @turn += 1
    end

    puts "Sorry, you've run out of turns. The correct code was #{format_code(@secret_code)}."
  end

  private

  def generate_secret_code
    print "Enter your secret code (e.g., RGBY): "
    secret_input = gets.chomp.upcase

    unless valid_input?(secret_input)
      puts "Invalid input. Please enter a 4-character code using the colors R, G, B, Y, O, P."
      return generate_secret_code
    end

    @secret_code = secret_input.split('')
  end

  def auto_generate_secret_code
    @secret_code = Array.new(4) { COLORS.sample }
  end

  def select_role
    print "Do you want to be the code maker (enter 'M') or code breaker (enter 'B')? "
    role_input = gets.chomp.upcase

    case role_input
    when 'M' then :maker
    when 'B' then :breaker
    else
      puts "Invalid input. Please enter 'M' or 'B'."
      select_role
    end
  end

  def format_code(code)
    code.join('')
  end

  def display_secret_code
    puts "Secret code: #{format_code(@secret_code)}"
  end

  def human_guess
    print "Enter your guess (e.g., RGBY): "
    guess_input = gets.chomp.upcase

    unless valid_input?(guess_input)
      puts "Invalid input. Please enter a 4-character code using the colors R, G, B, Y, O, P."
      return human_guess
    end

    guess_input.split('')
  end

  def valid_input?(input)
    input.length == 4 && input.chars.all? { |color| COLORS.include?(color) }
  end

  def computer_guess
    Array.new(4) { COLORS.sample }
  end

  def evaluate_guess(guess)
    exact_matches = @secret_code.zip(guess).count { |a, b| a == b }
    color_matches = COLORS.sum { |color| [guess.count(color), @secret_code.count(color)].min } - exact_matches
    [exact_matches, color_matches]
  end

  def display_board(guess, exact_matches, color_matches)
    puts "\nTurn #{@turn}: #{format_code(guess)}   Exact Matches: #{exact_matches}   Color Matches: #{color_matches}"
  end
end

if __FILE__ == $PROGRAM_NAME
  Mastermind.new.play
end
