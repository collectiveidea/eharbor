require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  
  test "index" do
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:listings)
    assert assigns(:listings).include?(listings(:macbook))
    
    assert_select 'a[href=?]', listing_path(listings(:macbook)), listings(:macbook).title
  end
  
  test "show" do
    get :show, :id => listings(:macbook)
    assert_response :success
    assert_template 'show'
    assert_equal listings(:macbook), assigns(:listing)
    
    assert_select 'h2', listings(:macbook).title
  end
  
end
