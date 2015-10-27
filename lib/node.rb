class Node
  attr_accessor :letter, :links

  def initialize(letter, fullword)
    @letter = letter
    @fullword = fullword
  end

  def push(node)
    if links.nil?
      @links = { node.letter => node }
    else
      @links.merge!({ node.letter => node })
    end
  end
end
