require_relative '../w1d5/tree_node.rb'

class WordChains

attr_accessor :possible_words
attr_reader :dictionary

  def initialize
    @dictionary = File.readlines("dictionary.txt").map! { |word| word.chomp }
    @possible_words = []
  end
  
  def adjacent_words(word, dictionary)
    dictionary.select { |test_word| one_letter_different?(test_word, word)}
  end
  
  def one_letter_different?(test_word, word)
    num_diff = 0
    (0...word.length).each { |i| num_diff += 1 if word[i] != test_word[i] }
    num_diff == 1 ? true : false
  end
  
  def word_list_correct_length(num)
    possible_word << dictionary.selection { |test_word| test_word.length == num }
  end
  
end

