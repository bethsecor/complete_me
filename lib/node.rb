class Node
  attr_accessor :letter, :links

  def initialize(letter)
    @letter = letter
  end

  def push(node)
    if links.nil?
      @links = { letter => node }
    else
      @links.merge!({ letter => node })
    end
    # @links.push(node)
  end
end
