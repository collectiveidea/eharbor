require 'test_helper'

class ListingTest < ActiveSupport::TestCase

  def valid_listing_attrs(attrs = {})
    {:title => 'Title', :description => 'Description'}.merge(attrs)
  end

  test "is invalid without a title" do
    listing = Listing.new valid_listing_attrs(:title => nil)
    assert !listing.valid?
    assert !listing.errors.on(:title).blank?
    listing.title = 'A Listing'
    listing.valid?
    assert listing.errors.on(:title).blank?
  end

  test "is invalid without a description" do
    listing = Listing.new valid_listing_attrs(:description => nil)
    assert !listing.valid?
    assert !listing.errors.on(:description).blank?
    listing.description = 'A description'
    listing.valid?
    assert listing.errors.on(:description).blank?
  end

  test "highest bid should return the highest bid" do
    listings(:macbook).bids.create! :amount => 1, :user => users(:daniel)
    bid = listings(:macbook).bids.create! :amount => 2, :user => users(:daniel)
    assert_equal bid, listings(:macbook).highest_bid
  end
end
