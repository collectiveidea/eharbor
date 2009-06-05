require 'spec_helper'

describe User do
  describe "validations" do
    it "should not be valid without a nickname" do
      @user = Factory.build(:user, :nickname => nil)
      @user.should_not be_valid
      @user.nickname = "tom"
      @user.should be_valid
    end
  end
end
