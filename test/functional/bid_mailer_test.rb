require 'test_helper'

class BidMailerTest < ActionMailer::TestCase  
  include Rails.application.routes.url_helpers
  
  setup do
    @listing = listings(:macbook)
    @bid = listings(:macbook).bids.build(:amount => 200)
    @bid.user = users(:amy)
    @bid.save!
    new_bid = listings(:macbook).bids.build(:amount => 300)
    new_bid.user = users(:amy)
    new_bid.save!
    @notification = BidMailer.outbid_notification(@bid)
  end
  
  test "outbid notification should send email to bidder" do
    assert @notification.to.include?(@bid.user.email)
  end
  
  test "outbid notification should have a link to the listing" do
    assert_match Regexp.new(listing_path(@listing)), @notification.body.to_s
  end
end
