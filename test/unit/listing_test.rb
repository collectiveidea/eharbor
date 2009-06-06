require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  
  should_validate_presence_of :title, :description
  should_belong_to :user
  should_have_many :bids
end
