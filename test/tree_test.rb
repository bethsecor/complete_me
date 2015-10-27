gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/tree'

class TreeTest < Minitest::Test
  def test_tree_methods_exist
    tree = Tree.new
    assert tree.respond_to?(:push)
  end

  def test_tree_pushes_one_letter
    tree = Tree.new
    tree.push("p", false)
    puts tree.inspect
    assert_equal "p", tree.head.links["p"].letter
  end

  def test_tree_pushes_one_letter
    tree = Tree.new
    tree.push("p", false)
    tree.push("i", false)
    puts tree.inspect
    assert_equal "p", tree.head.links["p"].letter
  end
end
