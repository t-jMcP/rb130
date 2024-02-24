require 'minitest/autorun'

require_relative 'car'

class CarTest < Minitest::Test
  def test_value_equality
    car1 = Car.new
    car2 = car1

    car1.name = "Kim"

    assert_equal(car1, car2)
  end
end
