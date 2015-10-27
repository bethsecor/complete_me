require_relative 'tree'

class CompleteMe
  attr_reader :count

  def initialize
    @tree = Tree.new
    @count = 0
  end

  def insert(word)
    @tree.insert(word)
    @count += 1
  end

  def suggest(string)
    @tree.suggest(string)
  end
end
