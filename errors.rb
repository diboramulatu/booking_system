# Custom exceptions for the lab booking system
class BookingError < StandardError; end
class ResourceUnavailableError < BookingError; end
class InvalidRoleError < BookingError; end
class InvalidStatusError < BookingError; end