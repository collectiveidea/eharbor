require 'test_helper'

class BidTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :listing
  
  should_allow_mass_assignment_of  :amount
  should_not_allow_mass_assignment_of  :user_id, :listing_id
  
  context "validations" do
    setup do
      @bid = Factory(:bid, :amount => 100)
    end
    
    should "be invalid when lower than highest bid" do
      bid = Factory.build(:bid, :listing => @bid.listing, :amount => 99.99)
      assert !bid.valid?
      assert_not_nil bid.errors.on(:amount)
    end
    
    should "be invalid when equal to highest bid" do
      bid = Factory.build(:bid, :listing => @bid.listing, :amount => 100)
      assert !bid.valid?
      assert_not_nil bid.errors.on(:amount)
    end
    
    should "be valid when greater than highest bid" do
      bid = Factory.build(:bid, :listing => @bid.listing, :amount => 100.01)
      assert bid.valid?
    end
    
    should "be invalid when listing is expired" do
      listing = Factory(:listing, :created_at => 1.week.ago)
      bid = Factory.build(:bid, :listing => listing)
      assert !bid.valid?
    end
    
  end

end
