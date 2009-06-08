require 'test_helper'

class BidObserverTest < ActiveSupport::TestCase
  
  context "after_create" do
    setup do
      ActionMailer::Base.deliveries = []
      @listing = Factory(:listing)
    end
    
    should "send an email if there is a previous bid" do
      Factory(:bid, :amount => 10, :listing => @listing)
      Factory(:bid, :amount => 12, :listing => @listing)
      assert_sent_email
    end
    
    should "not send an email if it is the first bid" do
      Factory(:bid, :amount => 10, :listing => @listing)
      assert_did_not_send_email
    end
  end
  
end
