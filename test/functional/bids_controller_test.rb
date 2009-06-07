require 'test_helper'

class BidsControllerTest < ActionController::TestCase
  def setup
    @listing = Factory(:listing)
  end

  test "create when not signed in" do
    post :create, :listing_id => @listing
    assert_redirected_to sign_in_path
  end
  
  test "create" do
    sign_in_as Factory(:user)
    assert_difference 'Bid.count' do
      post :create, :listing_id => @listing, :bid => {:amount => 20}
    end
    assert_response :redirect
    assert_redirected_to listing_path(@listing)
  end

end
