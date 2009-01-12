require 'test_helper'

class BidTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :listing
  
  context "validations" do
    setup do
      listings(:macbook).bids.create! :amount => 100, :user => users(:daniel)
    end
    
    should "be invalid when lower than highest bid" do
      bid = listings(:macbook).bids.build :amount => 99.99, :user => users(:daniel)
      assert !bid.valid?
      assert_not_nil bid.errors.on(:amount)
    end
    
    should "be invalid when equal to highest bid" do
      bid = listings(:macbook).bids.build :amount => 100, :user => users(:daniel)
      assert !bid.valid?
      assert_not_nil bid.errors.on(:amount)
    end
    
    should "be valid when greater than highest bid" do
      bid = listings(:macbook).bids.build :amount => 100.01, :user => users(:daniel)
      assert bid.valid?
    end
    
    should "be invalid when listing is expired" do
      listings(:macbook).end_at = 5.seconds.ago
      listings(:macbook).save!
      bid = listings(:macbook).bids.build :amount => 100, :user => users(:daniel)
      assert !bid.valid?
    end
    
  end

end
