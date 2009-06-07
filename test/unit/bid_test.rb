require 'test_helper'

class BidTest < ActiveSupport::TestCase  
  
  def setup
    @bid = Factory(:bid, :amount => 100)
  end
  
  test "highest bid should be invalid when lower than highest bid" do
    bid = Factory.build(:bid, :listing => @bid.listing, :amount => 99.99)
    assert !bid.valid?
    assert_not_nil bid.errors.on(:amount)
  end
  
  test "highest bid should be invalid when equal to highest bid" do
    bid = Factory.build(:bid, :listing => @bid.listing, :amount => 100)
    assert !bid.valid?
    assert_not_nil bid.errors.on(:amount)
  end
  
  test "highest bid should be valid when greater than highest bid" do
    bid = Factory.build(:bid, :listing => @bid.listing, :amount => 100.01)
    assert bid.valid?
  end

  test "should be invalid when listing is expired" do
    listing = Factory(:listing, :created_at => 1.week.ago)
    bid = Factory.build(:bid, :listing => listing)
    assert !bid.valid?
  end
end
