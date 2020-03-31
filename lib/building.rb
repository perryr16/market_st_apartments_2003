class Building

  attr_reader :units, :renters
  def initialize
    @units = []
    # @renters = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    @renters = []
    @units.each do |unit|
      @renters << unit.renter.name if unit.renter != nil
    end
    @renters
  end

  def average_rent
    sum = @units.sum { |unit| unit.monthly_rent}
    (sum.to_f / units.length.to_f).round(1)
  end

  def rented_units
    @rented_units = []
    @units.each do |unit|
      @rented_units << unit if unit.renter != nil
    end
    @rented_units
  end

  def renter_with_highest_rent
    @renter_with_highest_rent = nil
    if rented_units != []
      @renter_with_highest_rent = rented_units.max_by { |unit| unit.monthly_rent}
      @renter_with_highest_rent = @renter_with_highest_rent.renter
    end
  end

  def units_by_number_of_bedrooms
    units_by_number_of_brooms = {}
    @units.each do |unit|
      if units_by_number_of_brooms[unit.bedrooms] == nil
        units_by_number_of_brooms[unit.bedrooms] = [unit.number]
      else
        units_by_number_of_brooms[unit.bedrooms] << unit.number
      end
    end
    units_by_number_of_brooms
  end

  def annual_breakdown
    anual_breakdown = {}
    rented_units.each do |unit|
      anual_breakdown[unit.renter.name] = unit.monthly_rent * 12
    end
    anual_breakdown
  end

  def rooms_by_renter
    rooms_by_renter = {}
    rented_units.each do |unit|
      rooms_by_renter[unit.renter] = {bathrooms: unit.bathrooms, bedrooms: unit.bedrooms}
    end
    rooms_by_renter
  end

end
