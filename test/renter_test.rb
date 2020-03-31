require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/renter'
require './lib/apartment'
class RenterTest < Minitest::Test

  def test_it_exists
    renter1 = Renter.new("Jessie")

    assert_instance_of Renter, renter1
  end

  def test_it_returns_renter_name
    renter1 = Renter.new("Jessie")

    assert_equal "Jessie", renter1.name
  end

end


#
# unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
# # => #<Apartment:0x00007fb3ecaae7c0...>
#
# unit1.number
# # => "A1"
#
# unit1.monthly_rent
# # => 1200
#
# unit1.bathrooms
# # => 1
#
# unit1.bedrooms
# # => 1
#
# unit1.renter
# # => nil
#
# unit1.add_renter(renter1)
#
# unit1.renter
# # => #<Renter:0x00007fb3ee106ce8...>
