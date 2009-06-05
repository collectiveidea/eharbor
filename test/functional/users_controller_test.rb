require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "show" do
    get :show, :id => users(:brandon)
    
    assert_response :success
    assert_template 'show'
    assert_equal users(:brandon), assigns(:user)
    assert_select 'a[href=?]', listing_path(listings(:macbook))
    assert_select 'a[href=?]', edit_profile_path, false
  end
  
  test "show when signed in" do
    sign_in_as users(:brandon)
    get :show, :id => users(:brandon)
    assert_select 'a[href=?]', edit_profile_path
  end
  
  test "edit" do
    sign_in_as users(:brandon)
    get :edit, :id => users(:brandon)
    
    assert_response :success
    assert_template 'edit'
    assert_equal users(:brandon), assigns(:user)
  end
  
  test "update" do
    sign_in_as users(:brandon)
    put :update, :id => users(:brandon), :user => {:email => 'brandon@example.com'}
    
    assert_response :redirect
    assert_redirected_to user_path(users(:brandon))
  end
  
end
