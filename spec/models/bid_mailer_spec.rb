require 'spec_helper'

describe BidMailer do
  before do
    @listing = Factory(:listing)
    @bid = Factory(:bid, :amount => 10, :listing => @listing)
    Factory(:bid, :amount => 11, :listing => @listing)
  end
  
  describe "outbid_notification" do
    before do
      @notification = BidMailer.create_outbid_notification(@bid)
    end
    it "should send email to original bidder" do
      @notification.to.should include(@bid.user.email)
    end
    it "should have a link to the listing" do
      @notification.body.should include(listing_path(@listing))
    end
  end
  
  describe "seller_notification" do
    before do
      @notification = BidMailer.create_seller_notification(@bid)
    end
    it "should send email to seller" do
      @notification.to.should include(@listing.user.email)
    end
    it "should have a link to the listing" do
      include ActionController::UrlWriter
      @notification.body.should include(listing_path(@listing))
    end
  end
end