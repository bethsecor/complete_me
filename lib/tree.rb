require './lib/node'

class Tree
  attr_reader :head

  def push(letter, fullword)
    if head.nil?
      @head = Node.new(" ", false)
    end
    node = Node.new(letter, fullword)
    head.push(node)
  end
end
