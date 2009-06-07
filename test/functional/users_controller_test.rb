require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = Factory(:user)
    @listing = Factory(:listing, :user => @user)    
  end
  
  test "show" do
    get :show, :id => @user
    
    assert_response :success
    assert_template 'show'
    assert_equal @user, assigns(:user)
    assert_select 'a[href=?]', listing_path(@listing)
    assert_select 'a[href=?]', edit_profile_path, false
  end
  
  test "show when signed in" do
    sign_in_as @user
    get :show, :id => @user
    assert_select 'a[href=?]', edit_profile_path
  end
  
  test "edit" do
    sign_in_as @user
    get :edit, :id => @user
    
    assert_response :success
    assert_template 'edit'
    assert_equal @user, assigns(:user)
  end
  
  test "update" do
    sign_in_as @user
    put :update, :id => @user, :user => {:email => 'brandon@example.com'}
    
    assert_response :redirect
    assert_redirected_to user_path(@user)
  end
  
end
