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
    return false if test_word.length != word.length #maybe not needed
    num_diff = 0
    (0...word.length).each { |i| num_diff += 1 if word[i] != test_word[i] }
    num_diff == 1 ? true : false
  end
  
  def word_list_correct_length(num)
    possible_words + dictionary.select { |test_word| test_word.length == num }
  end
  
  def build_tree(start_word, end_word)
    raise "Can't connect #{start_word} to #{end_word} as they aren't the same length" if start_word.length != end_word.length
    word_list_correct_length(start_word.length)
    # building the tree should loop till adjacent_words.empty?
    tree = TreeNode.new(start_word)
    possible_words -= [start_word]
    children = adjacent_words(start_word, possible_words)
    children.each do |child|
      TreeNode.new(child)
    end
  end
  
end

