require_relative "book_movie"
require "test/unit"

class TestMovie < Test::Unit::TestCase

  def test_seat_price
    assert_equal(560, BookMovie.new.find_total_sale_price_of_seats(["B1", "B4"]) )
    assert_equal(960, BookMovie.new.find_total_sale_price_of_seats(["A1", "A2", "A3"]) )
  end


end
