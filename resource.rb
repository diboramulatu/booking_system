# Resource class for the lab booking system

class Resource
  attr_reader :id, :name, :category

  def initialize(id:, name:, category:)
    @id = id
    @name = name
    @category = category
    @current_booking = nil
  end

  def available?
    @current_booking.nil?
  end

  def assign_booking(booking)
    @current_booking = booking
  end

  def clear_booking
    @current_booking = nil
  end

  def current_booking
    @current_booking
  end

  def to_s
    status = available? ? "available" : "booked"
    "Resource ##{@id}: #{@name} (#{@category}) - #{status}"
  end
end