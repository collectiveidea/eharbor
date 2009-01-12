require 'test_helper'

class ListingTest < ActiveSupport::TestCase

  def valid_listing_attrs(attrs = {})
    {:title => 'Title', :description => 'Description'}.merge(attrs)
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
    listings(:macbook).bids.create! :amount => 1, :user => users(:amy)
    bid = listings(:macbook).bids.create! :amount => 2, :user => users(:amy)
    assert_equal bid, listings(:macbook).highest_bid
  end
  
end
