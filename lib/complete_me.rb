require_relative 'tree'

class CompleteMe
  attr_reader :count

  def initialize
    @tree = Tree.new
    @count = 0
  end

  def insert(word)
    @count += 1
    @tree.insert(word)
  end

  def populate(string_of_words)
    words = string_of_words.chomp.split("\n")
    @count = 0
    words.each do |word|
      insert(word)
    end
  end

  def suggest(prefix)
    @tree.suggest(prefix)
  end

  def select(prefix, chosen_selection)
  end
end
