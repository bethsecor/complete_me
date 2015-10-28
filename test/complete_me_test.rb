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

  def test_insert_a_word
    completion = CompleteMe.new
    completion.insert("pizza")
    assert_equal 1, completion.count
  end

  def test_populates_two_words
    completion = CompleteMe.new
    tiny_dictionary = "pizza\nprogramming\n"
    completion.populate(tiny_dictionary)
    assert_equal 2, completion.count
  end

  def test_suggests_the_right_words
    completion = CompleteMe.new
    completion.insert("pi")
    completion.insert("pie")
    completion.insert("pizza")
    completion.insert("pizzeria")
    completion.insert("pizzicato")
    assert_equal ["pizza", "pizzeria", "pizzicato"], completion.suggest("piz")
    assert_equal ["pi", "pie", "pizza", "pizzeria", "pizzicato"], completion.suggest("pi")
  end
end
