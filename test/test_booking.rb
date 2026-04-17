# Tests for the lab booking system

require "minitest/autorun"
require_relative "../user"
require_relative "../resource"
require_relative "../booking"
require_relative "../errors"

class BookingTest < Minitest::Test
  def setup
    @user = User.new(id: 1, name: "Mahi", role: "student")
    @user2 = User.new(id: 2, name: "John", role: "assistant")
    @resource = Resource.new(id: 1, name: "Microscope", category: "lab")
    @resource2 = Resource.new(id: 2, name: "Projector", category: "presentation")
  end

  # Test 1: booking an available resource creates an active booking
  def test_booking_an_available_resource_creates_active_booking
    booking = Booking.new(user: @user, resource: @resource)
    assert_equal "active", booking.status
    assert_equal false, @resource.available?
    assert_equal booking, @resource.current_booking
  end

  # Test 2: booking an unavailable resource raises an error
  def test_booking_unavailable_resource_raises_error
    Booking.new(user: @user, resource: @resource)
    
    assert_raises(ResourceUnavailableError) do
      Booking.new(user: @user2, resource: @resource)
    end
  end

  # Test 3: cancelling a booking changes its status
  def test_cancelling_booking_changes_status
    booking = Booking.new(user: @user, resource: @resource)
    assert_equal "active", booking.status
    
    booking.cancel
    assert_equal "cancelled", booking.status
  end

  # Test 4: cancelling a booking makes the resource available again
  def test_cancelling_booking_makes_resource_available
    booking = Booking.new(user: @user, resource: @resource)
    assert_equal false, @resource.available?
    
    booking.cancel
    assert_equal true, @resource.available?
    assert_nil @resource.current_booking
  end
end