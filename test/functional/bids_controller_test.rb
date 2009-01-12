require 'test_helper'

class BidsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "create when not signed in" do
    sign_out :user
    post :create, :listing_id => listings(:macbook)
    assert_redirected_to new_user_session_path
  end
  
  test "create" do
    sign_in users(:amy)
    assert_difference('listings(:macbook).bids.count') do
      assert_difference('users(:amy).bids.count') do
        post :create, :listing_id => listings(:macbook), :bid => {:amount => 20}
      end
    end
    assert_redirected_to listings(:macbook)
  end
  
end
