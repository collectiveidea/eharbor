require 'test_helper'

class BidTest < ActiveSupport::TestCase  
  
  def setup
    listings(:macbook).bids.create! :amount => 100, :user => users(:daniel)
  end
    
  test "highest bid should be invalid when lower than highest bid" do
    bid = listings(:macbook).bids.build :amount => 99.99, :user => users(:daniel)
    assert !bid.valid?
    assert_not_nil bid.errors.on(:amount)
  end
  
  test "highest bid should be invalid when equal to highest bid" do
    bid = listings(:macbook).bids.build :amount => 100, :user => users(:daniel)
    assert !bid.valid?
    assert_not_nil bid.errors.on(:amount)
  end
  
  test "highest bid should be valid when greater than highest bid" do
    bid = listings(:macbook).bids.build :amount => 100.01, :user => users(:daniel)
    assert bid.valid?
  end
end
