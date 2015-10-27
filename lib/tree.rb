require './lib/node'

class Tree
  attr_reader :head

  def push(letter)
    if head.nil?
      @head = Node.new(" ")
    end
    node = Node.new(letter)
    head.push(node)
  end
end
