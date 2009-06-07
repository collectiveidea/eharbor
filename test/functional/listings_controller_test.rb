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
  
  test "show" do
    get :show, :id => listings(:macbook)
    assert_response :success
    assert_template 'show'
    assert_equal listings(:macbook), assigns(:listing)
    
    assert_select 'h2', listings(:macbook).title
  end
  
end
