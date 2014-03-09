
ALPHABET = ('a'..'z').to_a

class Hangman
  attr_accessor :guessed_letters, :revealed_word

  def initialize(setter = ComputerPlayerDumb.new, guesser = HumanPlayer.new)
    @setter = setter
    @guesser = guesser
    @revealed_word = setter.revealed_word # maybe make this get the reavled word from the player
    @guessed_letters = []
  end

end

class HumanPlayer
  attr_reader :revealed_word
  attr_accessor :guessed_letters
  
  def initialize
    @guessed_letters = []
  end
  
  def guess_a_letter # need an until, as so the human cannot repeat guesses, and also, inputs a letter
    puts "Guess a letter"
    guess = gets.chomp
    until (ALPHABET- guessed_letters).include?(guess)
      puts "Try again"
      guess = gets.chomp
    end
    guessed_letters << guess
    guess
  end

  # private ?
  def get_length # need to check input (make sure it is a number)
   puts "How long is your word?"
   word_length = gets.chomp.to_i
   @revealed_word = Array.new(word_length) 
  end
  
end

class ComputerPlayerDumb
  
  attr_reader :revealed_word
  attr_accessor :guessed_letters

  
  def initialize
    @secret_word = secret_word
    @revealed_word = hide_word
    @guessed_letters = []
  end
  
  def guess_a_letter
    pos_letters = ALPHABET - guessed_letters 
    guess = pos_letters.sample
    guessed_letters << guess
  end
       
   # private
  
  def secret_word
    words = File.readlines('dictionary.txt')
    @secret_word = words.sample.strip
  end
  
  def hide_word
    result = []
    @secret_word.each_char do |letter|
      letter =~ /[a-zA-Z]/ ? result << nil : result << letter
    end
    result
  end

end

class ComputerPlayerSmart < ComputerPlayerDumb

end
