class Apartment

  attr_reader :number, :monthly_rent, :bathrooms, :bedrooms, :renter
  def initialize(details)
    @details = details
    @number = details[:number]
    @monthly_rent = details[:monthly_rent]
    @bathrooms = details[:bathrooms]
    @bedrooms = details[:bedrooms]
    @renter = nil
  end

  def add_renter(renter)
    @renter = renter
  end

end
