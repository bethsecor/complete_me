class Node
  attr_accessor :letter, :links

  def initialize(letter)
    @letter = letter
    @is_word = false
    @links = {}
  end

  # to_link is the rest of the word
  # is_word will become true at the last to_link letter
  # empty node in links for a full word.

  def links_to?(letter)
    links.has_key?(letter)
  end

  def create_link(letter)
    links[letter] = Node.new(letter)
  end

  def link_for(letter)
    links[letter]
  end

  def insert(node)
    # take first letter of to_link
    # if links.keys.include?(letter)
    # then go to that letter's links and pass the rest of the word
    # links["p"].letter
    # else
    # create hash key in links with letter
    # and create new node (insert) with value letter and pass rest of the word

    # junk:
    # if links.nil?
    #   @links = { node.letter => node }
    # else
    #   # @links.merge!({ node.letter => node })
    # end
  end
end
