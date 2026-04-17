#!/usr/bin/env ruby
# Main application file for the lab booking system

require_relative 'errors'
require_relative 'user'
require_relative 'resource'
require_relative 'booking'

puts "=" * 50
puts "   CLI Lab Booking System - Demo"
puts "=" * 50

# Step 1: Create at least two users
puts "\n[Step 1] Creating users..."
user1 = User.new(id: 1, name: "Mahi", role: "student")
user2 = User.new(id: 2, name: "John", role: "assistant")

puts "  Created: #{user1}"
puts "  Created: #{user2}"

# Step 2: Create at least two resources
puts "\n[Step 2] Creating resources..."
resource1 = Resource.new(id: 1, name: "Microscope", category: "lab")
resource2 = Resource.new(id: 2, name: "Projector", category: "presentation")

puts "  Created: #{resource1}"
puts "  Created: #{resource2}"

# Step 3: Create one valid booking
puts "\n[Step 3] Creating a valid booking..."
begin
  booking1 = Booking.new(user: user1, resource: resource1)
  puts "  SUCCESS: #{booking1}"
  puts "  Resource status: #{resource1.available? ? 'available' : 'booked'}"
rescue BookingError => e
  puts "  ERROR: #{e.message}"
end

# Step 4: Try to create a conflicting booking for the same resource
puts "\n[Step 4] Attempting to book already booked resource..."
begin
  booking_conflict = Booking.new(user: user2, resource: resource1)
  puts "  SUCCESS: #{booking_conflict}"
rescue ResourceUnavailableError => e
  puts "  BLOCKED (as expected): #{e.message}"
end

# Step 5: Show current status
puts "\n[Step 5] Current booking status..."
puts "  Booking status: #{booking1.status}"
puts "  Resource available?: #{resource1.available?}"

# Step 6: Cancel the first booking
puts "\n[Step 6] Cancelling the first booking..."
if booking1.cancel
  puts "  SUCCESS: Booking cancelled"
else
  puts "  ERROR: Could not cancel booking"
end

# Step 7: Show that the resource becomes available again
puts "\n[Step 7] Showing resource is available again..."
puts "  Booking status: #{booking1.status}"
puts "  Resource available?: #{resource1.available?}"

# Step 8: Now we can book the previously booked resource
puts "\n[Step 8] Booking previously cancelled resource..."
begin
  booking2 = Booking.new(user: user2, resource: resource1)
  puts "  SUCCESS: #{booking2}"
rescue BookingError => e
  puts "  ERROR: #{e.message}"
end

puts "\n" + "=" * 50
puts "   Demo Complete!"
puts "=" * 50