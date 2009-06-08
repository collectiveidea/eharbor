require 'test_helper'

class BidObserverTest < ActiveSupport::TestCase
  
  setup do
    ActionMailer::Base.deliveries = []
    @listing = listings(:macbook)
    listings(:macbook).bids.destroy_all
  end
  
  test "it should send an email if there is a previous bid" do
    @bid = listings(:macbook).bids.build(:amount => 200)
    @bid.user = users(:amy)
    @bid.save!
    new_bid = listings(:macbook).bids.build(:amount => 300)
    new_bid.user = users(:amy)
    new_bid.save!
    assert !ActionMailer::Base.deliveries.empty?
  end
  
  test "it should not send an email if it is the first bid" do
    listings(:macbook).bids.destroy_all
    bid = listings(:macbook).bids.build(:amount => 200)
    bid.user = users(:amy)
    bid.save!
    assert ActionMailer::Base.deliveries.empty?
  end
  
end
