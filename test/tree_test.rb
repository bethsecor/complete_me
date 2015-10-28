gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/tree'

class TreeTest < Minitest::Test
  def test_tree_methods_exist
    tree = Tree.new
    assert tree.respond_to?(:insert)
  end

  def test_tree_inserts_one_letter_words
    tree = Tree.new
    tree.insert("A")
    assert_equal "A", tree.head.links["A"].letter
  end

  def test_tree_inserts_two_letter_word
    tree = Tree.new
    tree.insert("pi")
    assert_equal "p", tree.head.links["p"].letter
    assert_equal "i", tree.head.links["p"].links["i"].letter
  end

  def test_tree_inserts_three_words
    tree = Tree.new
    tree.insert("pizza")
    tree.insert("pizzeria")
    tree.insert("pie")
    assert_equal "p", tree.head.links["p"].letter
    assert_equal "i", tree.head.links["p"].links["i"].letter
    assert_equal "z", tree.head.links["p"].links["i"].links["z"].letter
    assert_equal "e", tree.head.links["p"].links["i"].links["e"].letter
    assert_equal "z", tree.head.links["p"].links["i"].links["z"].links["z"].letter

    # puts tree.head.links["p"].links["i"].links["z"].links
  end
end
