require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "is invalid without a nickname" do
    user = User.new
    user.valid?
    assert !user.errors.on(:nickname).blank?
    user.nickname = 'John Smith'
    user.valid?
    assert user.errors.on(:nickname).blank?
  end
end
