class Hangman
  attr_accessor :guessed_letters, :revealed_word

  def initialize(setter = ComputerPlayerDumb.new, guesser = HumanPlayer.new, revealed_word)
    @setter = setter
    @guesser = guesser
    @revealed_word = setter.revealed_word # maybe make this get the reavled word from the player
  end

end

class HumanPlayer
  attr_reader :revealed_word


  # private ?
  def get_length
   puts "How long is your word?"
   word_length = gets.chomp.to_i
   @revealed_word = Array.new(word_length) 
  end
  
end

class ComputerPlayerDumb
  attr_reader :revealed_word
  
    def initialize
        @secret_word = secret_word
        @revealed_word = hide_word
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
