class Hangman
  attr_accessor :guessed_letters, :revealed_word

  def initialize(player1, player2, revealed_word)
    @player1 = player1
    @player2 = player2
    @revealed_word = revealed_word # maybe make this get the reavled word from the player
  end

end

class HumanPlayer

end

class ComputerPlayDumb

end

class ComputerPlayerSmart

end
