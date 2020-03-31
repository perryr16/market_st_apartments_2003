require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/renter'
require './lib/apartment'
require './lib/building'
class BuildingTest < Minitest::Test

  def test_it_exists
    building = Building.new
    assert_instance_of Building, building
  end

  def test_it_can_add_units
    building = Building.new
    assert_equal [], building.units

    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    building.add_unit(unit1)
    building.add_unit(unit2)
    assert_equal [unit1, unit2], building.units
  end

  def test_it_adds_and_returns_renters
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    building.add_unit(unit1)
    building.add_unit(unit2)
    assert_equal [], building.renters
    renter1 = Renter.new("Aurora")
    unit1.add_renter(renter1)
    assert_equal ["Aurora"], building.renters
    renter2 = Renter.new("Tim")
    unit2.add_renter(renter2)
    assert_equal ["Aurora", "Tim"], building.renters
  end

  def test_it_returns_averag_rent
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    building.add_unit(unit1)
    building.add_unit(unit2)

    assert_equal 1099.5, building.average_rent
  end

  def test_it_returns_rented_units
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)

    assert_equal [], building.rented_units
    unit2.add_renter(renter1)
    assert_equal [unit2], building.rented_units
    unit3.add_renter(renter1)
    assert_equal [unit2, unit3], building.rented_units
  end

  def test_it_returns_renter_with_highest_rent
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    assert_nil building.renter_with_highest_rent
    unit2.add_renter(renter1)
    assert_equal renter1, building.renter_with_highest_rent
    renter2 = Renter.new("Jessie")
    unit1.add_renter(renter2)
    assert_equal renter2, building.renter_with_highest_rent
    renter3 = Renter.new("Max")
    unit3.add_renter(renter3)
    assert_equal renter2, building.renter_with_highest_rent
  end

  def test_it_returms_units_by_bedrooms
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 1, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 2, bedrooms: 3})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    building.add_unit(unit4)

    expected =  {
                  3 => ["D4" ],
                  2 => ["B2", "C3"],
                  1 => ["A1"]
                }

    assert_equal expected, building.units_by_number_of_bedrooms

  end

  def test_it_returns_anual_breakdown
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    unit2.add_renter(renter1)
    expected1 = {"Spencer" => 11988}
    assert_equal expected1, building.annual_breakdown

    renter2 = Renter.new("Jessie")
    unit1.add_renter(renter2)
    building.annual_breakdown
    expected2 = {"Jessie" => 14400, "Spencer" => 11988}
    assert_equal expected2, building.annual_breakdown

  end

  def test_it_returns_rooms_by_renter
    building = Building.new
    unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    unit2.add_renter(renter1)
    expected = {renter1 => {bathrooms: 2, bedrooms: 2}}
    assert_equal expected, building.rooms_by_renter
    renter2 = Renter.new("Jessie")
    unit1.add_renter(renter2)
    expected = {renter2 => {bathrooms: 1, bedrooms: 1},
                renter1 => {bathrooms: 2, bedrooms: 2}}

    assert_equal expected, building.rooms_by_renter
  end

end


# building.rooms_by_renter
# #=> {<Renter:0x00007fb333af5a80...> => {bathrooms: 1, bedrooms: 1},
# #    #<Renter:0x00007fb333d0d7f0...> => {bathrooms: 2, bedrooms: 2}}
