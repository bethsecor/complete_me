gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me'

class CompleteMeTest < Minitest::Test
  def test_complete_me_methods_exist
    completion = CompleteMe.new
    assert completion.respond_to?(:insert)
    assert completion.respond_to?(:count)
    assert completion.respond_to?(:suggest)
    assert completion.respond_to?(:populate)
    assert completion.respond_to?(:select)
  end

  def test_insert_a_one_letter_word
    completion = CompleteMe.new
    completion.insert("A")
    assert_equal 1, completion.count
  end

  def test_insert_a_small_word
    completion = CompleteMe.new
    completion.insert("pie")
    assert_equal 1, completion.count
  end

  def test_insert_a_word
    completion = CompleteMe.new
    completion.insert("pizza")
    assert_equal 1, completion.count
  end

  def test_insert_two_words
    completion = CompleteMe.new
    completion.insert("bread")
    completion.insert("biscuit")
    assert_equal 2, completion.count
  end

  def test_insert_three_words
    completion = CompleteMe.new
    completion.insert("bread")
    completion.insert("biscuit")
    completion.insert("rolls")
    assert_equal 3, completion.count
  end

  def test_populates_one_word
    completion = CompleteMe.new
    tiny_dictionary = "programming\n"
    completion.populate(tiny_dictionary)
    assert_equal 1, completion.count
  end

  def test_populates_two_words
    completion = CompleteMe.new
    tiny_dictionary = "pizza\nprogramming\n"
    completion.populate(tiny_dictionary)
    assert_equal 2, completion.count
  end

  def test_populates_three_words
    completion = CompleteMe.new
    tiny_dictionary = "British\nbaking\nshow\n"
    completion.populate(tiny_dictionary)
    assert_equal 3, completion.count
  end

  def test_populates_several_words
    completion = CompleteMe.new
    tiny_dictionary = "I\nam\nwatching\nthe\ngreat\nBritish\nbaking\nshow\n"
    completion.populate(tiny_dictionary)
    assert_equal 8, completion.count
  end

  def test_populates_dictionary
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    assert_equal 235886, completion.count
  end

  def test_suggests_the_one_word_inserted
    completion = CompleteMe.new
    completion.insert("cake")
    assert_equal ["cake"], completion.suggest("")
    assert_equal ["cake"], completion.suggest("c")
    assert_equal ["cake"], completion.suggest("ca")
    assert_equal ["cake"], completion.suggest("cak")
    assert_equal ["cake"], completion.suggest("cake")
  end

  def test_suggests_nothing_for_prefix_not_in_tree
    completion = CompleteMe.new
    completion.insert("cake")
    assert_equal [], completion.suggest("ra")
    assert_equal [], completion.suggest("b")
  end

  def test_suggests_the_right_words
    completion = CompleteMe.new
    completion.insert("pi")
    completion.insert("pie")
    completion.insert("pizza")
    completion.insert("pizzeria")
    completion.insert("pizzicato")
    assert_equal ["pizza", "pizzeria", "pizzicato"], completion.suggest("piz")
    refute_equal ["pie", "pizza", "pizzeria", "pizzicato"], completion.suggest("piz")
    refute_equal ["pi", "pie", "pizza", "pizzeria", "pizzicato"], completion.suggest("piz")
    assert_equal ["pi", "pie", "pizza", "pizzeria", "pizzicato"], completion.suggest("pi")
    assert_equal ["pi", "pie", "pizza", "pizzeria", "pizzicato"], completion.suggest("p")
    assert_equal ["pi", "pie", "pizza", "pizzeria", "pizzicato"], completion.suggest("")
  end

  def test_select_changes_order_of_suggestions
    completion = CompleteMe.new
    completion.insert("pi")
    completion.insert("pie")
    completion.insert("pizza")
    completion.insert("pizzeria")
    completion.insert("pizzicato")
    completion.select("piz", "pizza")
    assert_equal ["pizza", "pi", "pie", "pizzeria", "pizzicato"], completion.suggest("pi")
  end
end
