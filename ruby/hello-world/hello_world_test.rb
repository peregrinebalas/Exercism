require 'minitest/autorun'
require_relative 'hello_world'

class HelloWorldTest < Minitest::Test
  def test_say_hi
    assert_equal "Hello, World!", HelloWorld.hello
  end
end
