require 'test_helper'

class BidTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :listing
end
