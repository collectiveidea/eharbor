require 'test_helper'

class ListingTest < ActiveSupport::TestCase

  def valid_listing_attrs(attrs = {})
    {:title => 'Title', :description => 'Description'}.merge(attrs)
  end
  
  def setup
    @macbook = Factory(:listing)
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
    Factory(:bid, :listing => @macbook, :amount => 1)
    bid = Factory(:bid, :listing => @macbook, :amount => 2)
    assert_equal bid, @macbook.highest_bid
  end

  test "active should not include listings that have ended" do
    assert !Listing.active.include?(Factory(:listing, :created_at => 30.days.ago))
  end

  test "active should include listings that have not ended" do
    listing = Factory(:listing, :created_at => 3.days.ago, :duration => 7)
    assert Listing.active.include?(listing)
  end

end
