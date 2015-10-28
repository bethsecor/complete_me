require './lib/node'
require 'pry'

class Tree
  attr_reader :head

  def initialize
      @head = Node.new("")
  end

  def insert(word)
    node = @head

    word.chars.each do |letter|
      unless node.links_to?(letter)
        node.create_link(letter)
      end
      node = node.link_for(letter)
    end
    node.create_link("")
  end

  def prefix_links(prefix)
    link = "@head"
    prefix.chars.each do |letter|
      link += ".links['#{letter}']"
    end
    eval(link).links
  end

  def add_letters(prefix, array_suggestions=[])
    starting_links = prefix_links(prefix)
    starting_links.each_with_index do |(letter, node), i|
      prefix = prefix.chop if i > 0
      prefix += letter
      if letter == ""
        array_suggestions << prefix
      end
      # binding.pry
      node.add_letters(prefix, array_suggestions)
    end
    array_suggestions
  end

  def suggest(prefix)
    add_letters(prefix)
  end
end
