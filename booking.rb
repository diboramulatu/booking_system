# Booking class for the lab booking system

require_relative 'errors'
require_relative 'resource'

class Booking
  attr_reader :user, :resource, :created_at
  attr_accessor :status

  VALID_STATUSES = ['active', 'cancelled', 'completed'].freeze

  def initialize(user:, resource:)
    @user = user
    @resource = resource
    @created_at = Time.now
    @status = 'active'
    
    validate_and_book
  end

  def cancel
    return false unless @status == 'active'
    
    @status = 'cancelled'
    @resource.clear_booking
    true
  end

  def active?
    @status == 'active'
  end

  def cancelled?
    @status == 'cancelled'
  end

  def to_s
    "Booking: #{@user.name} -> #{@resource.name} [#{@status}] at #{@created_at.strftime('%Y-%m-%d %H:%M')}"
  end

  private

  def validate_and_book
    # Check if user can book
    unless @user.can_book?
      raise InvalidRoleError, "User with role '#{@user.role}' cannot create bookings"
    end

    # Check if resource is available
    unless @resource.available?
      raise ResourceUnavailableError, "Resource '#{@resource.name}' is already booked"
    end

    # Assign booking to resource
    @resource.assign_booking(self)
  end
end