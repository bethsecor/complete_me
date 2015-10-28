require 'pry'

class Node
  attr_accessor :letter, :links

  def initialize(letter)
    @letter = letter
    @links = {}
  end

  def links_to?(letter)
    links.has_key?(letter)
  end

  def create_link(letter)
    links[letter] = Node.new(letter)
  end

  def link_for(letter)
    links[letter]
  end

  def add_letters(prefix, array_suggestions=[])
    @links.each do |letter, node|
      prefix += letter
      if letter == ""
        array_suggestions << prefix
      end
      # binding.pry
      node.add_letters(prefix, array_suggestions)
    end
    array_suggestions
  end
end
