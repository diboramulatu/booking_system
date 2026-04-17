# User class for the lab booking system

class User
  attr_reader :id, :name, :role

  VALID_ROLES = ['student', 'assistant', 'admin'].freeze

  def initialize(id:, name:, role:)
    @id = id
    @name = name
    @role = validate_role(role)
  end

  def can_book?
    ['student', 'assistant'].include?(@role)
  end

  def to_s
    "User ##{@id}: #{@name} (#{@role})"
  end

  private

  def validate_role(role)
    role = role.to_s.downcase
    unless VALID_ROLES.include?(role)
      raise InvalidRoleError, "Invalid role: #{role}. Valid roles are: #{VALID_ROLES.join(', ')}"
    end
    role
  end
end
