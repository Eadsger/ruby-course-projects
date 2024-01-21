require 'json'

class Hangman
  attr_accessor :secret_word, :guessed_letters, :incorrect_guesses, :max_attempts

  def initialize
    @dictionary = File.readlines('google-10000-english-no-swears.txt').map(&:chomp).select { |word| word.length.between?(5, 12) }
    @secret_word = select_random_word
    @guessed_letters = []
    @incorrect_guesses = 0
    @max_attempts = 6
  end

  def select_random_word
    @dictionary.sample
  end

  def display_word
    display = @secret_word.chars.map { |char| @guessed_letters.include?(char.downcase) ? char : '_' }.join(' ')
    puts display
  end

  def display_status
    puts "Incorrect guesses left: #{@max_attempts - @incorrect_guesses}"
    puts "Guessed letters: #{@guessed_letters.join(', ')}"
  end

  def make_guess(letter)
    letter.downcase!

    if @guessed_letters.include?(letter)
      puts "You already guessed '#{letter}'. Try again."
    else
      @guessed_letters << letter

      if @secret_word.downcase.include?(letter)
        puts "Correct guess!"
      else
        @incorrect_guesses += 1
        puts "Incorrect guess!"
      end
    end
  end

  def save_game
    game_state = {
      secret_word: @secret_word,
      guessed_letters: @guessed_letters,
      incorrect_guesses: @incorrect_guesses,
      max_attempts: @max_attempts
    }

    File.open('hangman_save.json', 'w') { |file| file.puts game_state.to_json }
    puts "Game saved!"
  end

  def load_game
    saved_game = JSON.parse(File.read('hangman_save.json'))

    @secret_word = saved_game['secret_word']
    @guessed_letters = saved_game['guessed_letters']
    @incorrect_guesses = saved_game['incorrect_guesses']
    @max_attempts = saved_game['max_attempts']

    puts "Game loaded!"
  end

  def play
    loop do
      display_word
      display_status

      puts "Enter a letter to guess, 'save' to save the game, or 'exit' to quit:"
      input = gets.chomp.downcase

      case input
      when 'save'
        save_game
      when 'exit'
        break
      else
        make_guess(input)
      end

      if @guessed_letters.uniq.sort == @secret_word.downcase.chars.uniq.sort
        puts "Congratulations! You guessed the word: #{@secret_word}"
        break
      elsif @incorrect_guesses >= @max_attempts
        puts "Sorry, you're out of attempts. The word was #{@secret_word}"
        break
      end
    end
  end
end

def start_game
  puts "Welcome to Hangman!"

  if File.exist?('hangman_save.json')
    puts "Do you want to start a new game or load a saved game? (new/load)"
    choice = gets.chomp.downcase

    if choice == 'load'
      hangman_game = Hangman.new
      hangman_game.load_game
    else
      hangman_game = Hangman.new
    end
  else
    hangman_game = Hangman.new
  end

  hangman_game.play
end

start_game
