require 'test_helper'

class BidMailerTest < ActionMailer::TestCase
  include ActionController::UrlWriter
  
  def setup
    @listing = Factory(:listing)
    @bid = Factory(:bid, :amount => 10, :listing => @listing)
    Factory(:bid, :amount => 11, :listing => @listing)
    @notification = BidMailer.create_outbid_notification(@bid)
  end

  test "outbid_notification should send email to bidder" do
    assert @notification.to.include?(@bid.user.email)
  end
    
  test "outbid_notification should have a link to the listing" do
    assert_match listing_path(@listing), @notification.body
  end
end
