require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  should_validate_presence_of :title, :description
  should_allow_values_for :duration, 3, 5, 7
  should_not_allow_values_for :duration, nil, 0, 1, 8, :message => //
  should_allow_mass_assignment_of  :title, :description, :duration
  should_not_allow_mass_assignment_of :user_id, :end_at
  
  should_belong_to :user
  should_have_many :bids
  
  context "highest_bid" do
    should "return the highest bid" do
      listing = Factory(:listing)
      Factory(:bid, :amount => 1, :listing => listing)
      bid = Factory(:bid, :amount => 2, :listing => listing)
      assert_equal bid, listing.highest_bid
    end
  end

  context "active" do
    should "not include listings that have ended" do
      listing = Factory(:listing, :created_at => 4.days.ago, :duration => 3)
      assert !Listing.active.include?(listing)
    end

    should "include listings that have not ended" do
      listing = Factory(:listing, :created_at => 10.seconds.ago)
      assert Listing.active.include?(listing)
    end
  end

end
