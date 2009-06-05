require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_validate_presence_of :nickname
  should_validate_uniqueness_of :nickname, :case_sensitive => false
  should_allow_mass_assignment_of :nickname
end
