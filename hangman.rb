
require 'debugger'

ALPHABET = ('a'..'z').to_a
MAX_NUM_BAD_GUESSES = 10

class Hangman
  attr_accessor :revealed_word

  def initialize(setter = ComputerPlayerDumb.new, guesser = HumanPlayer.new)
    @setter = setter
    @guesser = guesser
    @revealed_word = @setter.set_revealed_word # maybe make this get the reavled word from the player
    @guessed_letters = []
  end
  
  def run
   # debugger
   # @setter.set_revealed_word
    until won? || lost?
      puts "Maybe I should have the number of guesses left here."
      print "You've guessed: #{@guesser.guessed_letters.join(', ')}\n"
      render_revealed_word
      guess = @guesser.guess_a_letter
      @setter.update_revealed_word(guess)
    end
    if won?
      puts "You guessed my word!"
    elsif lost?
      puts "Better luck next time."
    end
  end
  
  def render_revealed_word
    result = []
    revealed_word.each do |letter|
      if letter =~ /\w/
        result << letter
      else
        result << "_"
      end
    end
    puts "Secret word: #{result.join(' ')}"
  end
  
  def won?
    revealed_word.length == revealed_word.compact.length
  end
  
  def lost?
    (@guesser.guessed_letters - revealed_word.compact).length == MAX_NUM_BAD_GUESSES
  end

end

class HumanPlayer
  attr_reader :revealed_word
  attr_accessor :guessed_letters
  
  def initialize
    @guessed_letters = []
    @revealed_word = []
  end
  
  def guess_a_letter 
    puts "Guess a letter"
    print "> "
    guess = gets.chomp
    until (ALPHABET- guessed_letters).include?(guess)
      puts "Try again"
      print "> "
      guess = gets.chomp
    end
    guessed_letters << guess
    guess
  end

  # private ?
  def set_revealed_word # need to check input (make sure it is a number)
   puts "How long is your word?"
   print "> "
   word_length = gets.chomp.to_i
   @revealed_word = Array.new(word_length) 
  end
  
  def update_revealed_word(str)
    if letter_in_word(str)
      number_letter_in_word(str).to_i.times do |i|
        puts render_revealed_word
        numbers = []
        (1..revealed_word.length).each do |i|
          numbers << i
        end
        puts numbers.join("\t")
        begin
          puts "Where does #{str} occur in your word?"
          print "> "
          index = gets.chomp
          Integer(index)
        rescue
          retry
        end
      @revealed_word[index.to_i - 1] = str
      end
    end
    
  end
  
  def number_letter_in_word(str)
    begin
      puts "How many times is #{str} in your word?"
      print "> "
      number = gets.chomp
      Integer(number)
    rescue
      retry
    end
    return number
  end
  
  def render_revealed_word
    result_string = []
    revealed_word.each do |letter|
      if letter.nil?
        result_string << "_"
      else
        result_string << letter
      end
    end
    result_string.join("\t")
  end
  
  def letter_in_word?(str)
    puts "Is #{str} in your word? y/n"
    print "> "
    in_out = gets.chomp.downcase
    until ["y", 'n'].include?(in_out)
      puts "Is #{str} in your word? y/n"
      print "> "
      in_out = gets.chomp.downcase
    end
    return in_out == 'y'
  end
  
end

class ComputerPlayerDumb
  
  attr_reader :revealed_word
  attr_accessor :guessed_letters

  
  def initialize
    @secret_word = secret_word
    @revealed_word = set_revealed_word
    @guessed_letters = []
  end
  
  def guess_a_letter
    pos_letters = ALPHABET - guessed_letters 
    guess = pos_letters.sample
    guessed_letters << guess
  end
  
  def update_revealed_word(str)
    good_idx = []
    i = 0
    @secret_word.each_char do |sec_letter|
      good_idx << i if sec_letter == str
      i += 1
    end
    good_idx.each do |index|
      @revealed_word[index] = str
    end
    
  end
  
  def letter_in_word?(str)
    @secret_word.include?(str)
  end
  
  def set_revealed_word
    result = []
    @secret_word.each_char do |letter|
      letter =~ /[a-zA-Z]/ ? result << nil : result << letter
    end
    result
  end
       
   # private
  
  def secret_word
    words = File.readlines('dictionary.txt')
    @secret_word = words.sample.strip
  end
  


end

class ComputerPlayerSmart < ComputerPlayerDumb

end
