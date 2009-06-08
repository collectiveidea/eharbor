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
    @outbid_notification = BidMailer.outbid_notification(@bid)
    @seller_notification = BidMailer.seller_notification(@bid)
  end
  
  test "outbid notification should send email to bidder" do
    assert @outbid_notification.to.include?(@bid.user.email)
  end
  
  test "outbid notification should have a link to the listing" do
    assert_match Regexp.new(listing_path(@listing)), @outbid_notification.body.to_s
  end
  
  test "seller notification should send email to seller" do
    assert @seller_notification.to.include?(@listing.user.email)
  end
  
  test "seller notification should have a link to the listing" do
    assert_match Regexp.new(listing_path(@listing)), @seller_notification.body.to_s
  end
end
