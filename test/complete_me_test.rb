gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me'

class CompleteMeTest < Minitest::Test
  def test_complete_me_methods_exist
    completion = CompleteMe.new
    assert completion.respond_to?(:insert)
    # assert completion.respond_to?(:count)
    # assert completion.respond_to?(:suggest)
    # assert completion.respond_to?(:populate)
    # assert completion.respond_to?(:select)
  end
end
