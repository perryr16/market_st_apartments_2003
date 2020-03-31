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
end
