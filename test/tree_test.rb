gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/tree'

class TreeTest < Minitest::Test
  def test_tree_methods_exist
    tree = Tree.new
    assert tree.respond_to?(:insert)
  end

  def test_tree_pushes_one_letter_words
    tree = Tree.new
    tree.insert("A")
    assert_equal "A", tree.head.links["A"].letter
  end

  def test_tree_pushes_two_letter_word
    tree = Tree.new
    tree.insert("pi")
    assert_equal "p", tree.head.links["p"].letter
    assert_equal "i", tree.head.links["p"].links["i"].letter
  end
end
