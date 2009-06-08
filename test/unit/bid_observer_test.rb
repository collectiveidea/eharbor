require 'test_helper'

class BidObserverTest < ActiveSupport::TestCase
  
  def setup
    ActionMailer::Base.deliveries = []
    @listing = Factory(:listing)
  end
  
  test "after_create should send an email if there is a previous bid" do
    bid1 = Factory(:bid, :amount => 10, :listing => @listing)
    bid2 = Factory(:bid, :amount => 12, :listing => @listing)
    email = ActionMailer::Base.deliveries.detect{|d| d.to.include?(bid1.user.email)}
    assert_not_nil email
  end
  
  test "after_create should not send an email if it is the first bid" do
    bid = Factory(:bid, :amount => 10, :listing => @listing)
    email = ActionMailer::Base.deliveries.detect{|d| d.to.include?(bid.user.email)}
    assert_nil email
  end
  
  test "after_create should send the seller an email" do
    Factory(:bid, :amount => 10, :listing => @listing)
    email = ActionMailer::Base.deliveries.select{|e| e.to.include?(@listing.user.email) }
    assert_not_nil email
  end
  
end
