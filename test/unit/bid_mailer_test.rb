require 'test_helper'

class BidMailerTest < ActionMailer::TestCase
  include ActionController::UrlWriter
  
  context "outbid_notification" do
    setup do
      @listing = Factory(:listing)
      @bid = Factory(:bid, :amount => 10, :listing => @listing)
      Factory(:bid, :amount => 11, :listing => @listing)
      @notification = BidMailer.create_outbid_notification(@bid)
    end
    
    should "send email to bidder" do
      assert_contains @notification.to, @bid.user.email
    end
    
    should "have a link to the listing" do
      assert_match listing_path(@listing), @notification.body
    end
  end
end
