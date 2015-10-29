require_relative 'node'
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
    node.create_link(" ")
  end

  def suggest(prefix)
    find_words(prefix).map { |word| word.chop }
  end

  def find_words(prefix)
    array_suggestions = []
    return array_suggestions if prefix_links(prefix).nil?
    prefix_links(prefix).each_with_index do |(letter, node), i|
      prefix = prefix.chop if i > 0
      prefix += letter
      add_word(letter, prefix, array_suggestions)
      node.find_words(prefix, array_suggestions)
    end
    array_suggestions
  end

  def prefix_links(prefix)
    node = @head
    prefix.chars.each do |letter|
      node = node.link_for(letter)
      return nil if node.nil?
    end
      node.links unless node.nil?
  end

  def add_word(letter, prefix, array_suggestions)
    if complete_word?(letter)
      array_suggestions << prefix
    end
  end

  def complete_word?(letter)
    letter == " "
  end
end
