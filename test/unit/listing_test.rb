require 'test_helper'

class ListingTest < ActiveSupport::TestCase

  def valid_listing_attrs(attrs = {})
    {:title => 'Title', :description => 'Description', :duration => 3}.merge(attrs)
  end

  test "is invalid without a title" do
    listing = Listing.new valid_listing_attrs(:title => nil)
    assert !listing.valid?
    listing.title = 'A Listing'
    assert listing.valid?
  end

  test "is invalid without a description" do
    listing = Listing.new valid_listing_attrs(:description => nil)
    assert !listing.valid?
    listing.description = 'A description'
    assert listing.valid?
  end

  test "highest_bid should return the highest bid" do
    bid1 = listings(:macbook).bids.build :amount => 1
    bid1.user = users(:amy)
    bid1.save!
    bid2 = listings(:macbook).bids.build :amount => 2
    bid2.user = users(:amy)
    bid2.save!
    assert_equal bid2, listings(:macbook).highest_bid
  end
  
  test "listing should include listings that have ended" do
    assert !Listing.active.include?(listings(:expired))
  end

  test "listing should include listings that have not ended" do
    listing = Listing.create valid_listing_attrs(:end_at => 3.days.from_now)
    assert Listing.active.include?(listing)
  end

end
