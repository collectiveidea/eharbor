require 'test_helper'

class BidTest < ActiveSupport::TestCase
  setup do
    listings(:macbook).bids.create! :amount => 100, :user => users(:amy)
  end
  
  test "bid is invalid when lower than highest bid" do
    bid = listings(:macbook).bids.build :amount => 99.99, :user => users(:amy)
    assert !bid.valid?
    assert_not_nil bid.errors[:amount]
  end
  
  test "bid is invalid when equal to highest bid" do
    bid = listings(:macbook).bids.build :amount => 100, :user => users(:amy)
    assert !bid.valid?
    assert_not_nil bid.errors[:amount]
  end
  
  test "bid is valid when greater than highest bid" do
    bid = listings(:macbook).bids.build :amount => 100.01, :user => users(:amy)
    assert bid.valid?
  end
  
  test "bid should be invalid when lower than highest bid" do
    bid = listings(:macbook).bids.build :amount => 99.99, :user => users(:amy)
    assert !bid.valid?
    assert_not_nil bid.errors[:amount]
  end
  
  test "bid should be invalid when equal to highest bid" do
    bid = listings(:macbook).bids.build :amount => 100, :user => users(:amy)
    assert !bid.valid?
    assert_not_nil bid.errors[:amount]
  end
  
  test "bid should be valid when greater than highest bid" do
    bid = listings(:macbook).bids.build :amount => 100.01, :user => users(:amy)
    assert bid.valid?
  end
  
  test "bid should be invalid when listing is expired" do
    listings(:macbook).end_at = 5.seconds.ago
    listings(:macbook).save!
    bid = listings(:macbook).bids.build :amount => 100, :user => users(:amy)
    assert !bid.valid?
  end
  

end
