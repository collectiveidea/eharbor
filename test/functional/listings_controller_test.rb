require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  
  test "index" do
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:listings)
    assert assigns(:listings).include?(listings(:macbook))
  end
  
end
