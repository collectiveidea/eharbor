require 'test_helper'

class BidObserverTest < ActiveSupport::TestCase
  
  context "after_create" do
    setup do
      ActionMailer::Base.deliveries = []
      @listing = Factory(:listing)
    end
    
    should "send an outbid email if there is a previous bid" do
      Factory(:bid, :amount => 10, :listing => @listing)
      Factory(:bid, :amount => 12, :listing => @listing)
      assert_sent_email do |email|
        email.subject =~ /outbid/
      end
    end
    
    should "not send an outbid email if it is the first bid" do
      Factory(:bid, :amount => 10, :listing => @listing)
      assert_nil ActionMailer::Base.deliveries.detect {|e| e.subject =~ /outbid/ }
    end
    
    should "send the seller an email" do
      Factory(:bid, :amount => 10, :listing => @listing)
      assert_sent_email do |email|
        email.to.include? @listing.user.email
      end
    end
  end
  
end
