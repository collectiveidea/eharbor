require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  should_validate_presence_of :title, :description
  should_belong_to :user
  should_have_many :bids
  
  context "highest_bid" do
    should "return the highest bid" do
      listings(:macbook).bids.create! :amount => 1, :user => users(:daniel)
      bid = listings(:macbook).bids.create! :amount => 2, :user => users(:daniel)
      assert_equal bid, listings(:macbook).highest_bid
    end
  end
end
