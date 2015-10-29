gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/tree'

class TreeTest < Minitest::Test
  def test_tree_methods_exist
    tree = Tree.new
    assert tree.respond_to?(:insert)
    assert tree.respond_to?(:suggest)
    assert tree.respond_to?(:find_words)
    assert tree.respond_to?(:prefix_links)
    assert tree.respond_to?(:add_word)
    assert tree.respond_to?(:complete_word?)
  end

  def test_tree_inserts_one_letter_word
    tree = Tree.new
    tree.insert("A")
    assert_equal "A", tree.head.links["A"].letter
  end

  def test_tree_inserts_two_letter_word
    tree = Tree.new
    tree.insert("pi")
    assert_equal "p", tree.head.links["p"].letter
    assert_equal "i", tree.head.links["p"].links["i"].letter
    assert_equal " ", tree.head.links["p"].links["i"].links[" "].letter
  end

  def test_tree_inserts_small_word
    tree = Tree.new
    tree.insert("cake")
    assert_equal "c", tree.head.links["c"].letter
    assert_equal "a", tree.head.links["c"].links["a"].letter
    assert_equal "k", tree.head.links["c"].links["a"].links["k"].letter
    assert_equal "e", tree.head.links["c"].links["a"].links["k"].links["e"].letter
    assert_equal " ", tree.head.links["c"].links["a"].links["k"].links["e"].links[" "].letter
  end

  def test_tree_inserts_larger_word
    tree = Tree.new
    tree.insert("hedgehog")
    assert_equal "h", tree.head.links["h"].letter
    assert_equal "e", tree.head.links["h"].links["e"].letter
    assert_equal "d", tree.head.links["h"].links["e"].links["d"].letter
    assert_equal "g", tree.head.links["h"].links["e"].links["d"].links["g"].letter
    assert_equal "e", tree.head.links["h"].links["e"].links["d"].links["g"].links["e"].letter
    assert_equal "h", tree.head.links["h"].links["e"].links["d"].links["g"].links["e"].links["h"].letter
    assert_equal "o", tree.head.links["h"].links["e"].links["d"].links["g"].links["e"].links["h"].links["o"].letter
    assert_equal "g", tree.head.links["h"].links["e"].links["d"].links["g"].links["e"].links["h"].links["o"].links["g"].letter
    assert_equal " ", tree.head.links["h"].links["e"].links["d"].links["g"].links["e"].links["h"].links["o"].links["g"].links[" "].letter
  end

  def test_tree_inserts_two_words
    tree = Tree.new
    tree.insert("garden")
    tree.insert("flower")
    assert_equal "g", tree.head.links["g"].letter
    assert_equal "f", tree.head.links["f"].letter
    assert_equal "a", tree.head.links["g"].links["a"].letter
    assert_equal "l", tree.head.links["f"].links["l"].letter
  end

  def test_tree_inserts_two_words_with_same_prefix
    tree = Tree.new
    tree.insert("chocolate")
    tree.insert("chips")
    assert_equal "c", tree.head.links["c"].letter
    assert_equal "h", tree.head.links["c"].links["h"].letter
    assert_equal "i", tree.head.links["c"].links["h"].links["i"].letter
    assert_equal "o", tree.head.links["c"].links["h"].links["o"].letter
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
  end

  def test_complete_word?
    tree = Tree.new
    refute tree.complete_word?("a")
    assert tree.complete_word?(" ")
  end
end
