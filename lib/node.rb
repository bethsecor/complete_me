# Creates nodes for the trie.
class Node
  attr_accessor :letter, :links

  def initialize(letter)
    @letter = letter
    @links = {}
  end

  def links_to?(letter)
    links.key?(letter)
  end

  def create_link(letter)
    links[letter] = Node.new(letter)
  end

  def link_for(letter)
    links[letter]
  end

  def complete_word?(letter)
    letter == ' '
  end

  def add_word(letter, prefix, array_suggestions)
    if complete_word?(letter)
      array_suggestions << prefix
    end
  end

  def find_words(prefix, array_suggestions)
    links.each_with_index do |(letter, node), i|
      prefix = prefix.chop if i > 0
      prefix += letter
      add_word(letter, prefix, array_suggestions)
      node.find_words(prefix, array_suggestions)
    end
    array_suggestions
  end
end
