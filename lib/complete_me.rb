require_relative 'tree'

# Creates a trie by inserting words or populating them from a
# string of words. Gives word suggestions based on a prefix.
# The suggestions order changes if the user selects a certain word.
class CompleteMe
  attr_reader :count

  def initialize
    @tree = Tree.new
    @count = 0
    @selections = {}
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
    suggestions = @tree.suggest(prefix)
    priorities = @selections.keys.select { |word| suggestions.include?(word) }
    suggestions -= priorities
    priorities + suggestions
  end

  def select(prefix, chosen_selection)
    if @selections.key?(chosen_selection)
      @selections[chosen_selection] += 1
    else
      @selections[chosen_selection] = 1
    end
    @selections = @selections.sort_by { |_key, value| value }.reverse.to_h
  end
end
