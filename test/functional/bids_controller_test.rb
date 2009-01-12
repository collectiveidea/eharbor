require 'test_helper'

class BidsControllerTest < ActionController::TestCase
  
  test "create when not signed in" do
    post :create, :listing_id => listings(:macbook)
    assert_redirected_to sign_in_path
  end
  
  test "create" do
    sign_in_as users(:brandon)
    assert_difference 'Bid.count' do
      post :create, :listing_id => listings(:macbook), :bid => {:amount => 20}
    end
    assert_response :redirect
    assert_redirected_to listing_path(listings(:macbook))
  end

end
