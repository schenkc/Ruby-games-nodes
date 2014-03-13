require_relative '../w1d5/tree_node.rb'

class WordChains

attr_accessor :possible_words
attr_reader :dictionary

  def initialize
    @dictionary = File.readlines("dictionary.txt").map! { |word| word.chomp }
    @possible_words = []
  end
  
  def adjacent_words(word, dictionary)
    dictionary.select { |test_word| one_letter_different(test_word, word)}
  end
  
  def one_letter_different(test_word, word)
  
  end
  
end

