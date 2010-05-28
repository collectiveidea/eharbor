require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  
  test "index" do
    listing = Listing.create! :title => 'Foo', :description => 'Bar'
    
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:listings)
    assert assigns(:listings).include?(listing)
  end
  
end
