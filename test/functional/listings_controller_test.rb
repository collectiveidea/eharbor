require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    sign_in users(:sam)
  end
  
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
  
  test "new" do
    get :new
    assert_response :success
    assert_template 'new'
    assert_not_nil assigns(:listing)
    
    assert_select 'form[action=?]', listings_path do
      assert_select 'input[type=text][name=?]', 'listing[title]'
      assert_select 'label[for=?]', 'listing_title'
      assert_select 'label[for=?]', 'listing_description'
      assert_select 'textarea[name=?]', 'listing[description]'
      assert_select 'input[type=submit]'
    end
  end
  
  test "new when not signed in" do
    sign_out :user
    get :new
    assert_redirected_to new_user_session_path
  end
  
  test "create" do
    assert_difference 'Listing.count' do
      post :create, :listing => {:title => 'Getting Testy', :description => "Lorem...", :duration => 3}
    end
    assert_response :redirect
    assert_redirected_to listing_path(assigns(:listing))
  end
  
  test "create when not signed in" do
    sign_out :user
    assert_no_difference 'Listing.count' do
      post :create, :listing => {:title => 'Getting Testy', :description => "Lorem...", :duration => 3}
    end
    assert_redirected_to new_user_session_path
  end
  
  test "edit" do
    get :edit, :id => listings(:macbook)
    assert_response :success
    assert_template 'edit'
    assert_equal listings(:macbook), assigns(:listing)
  end
  
  test "edit when not signed in" do
    sign_out :user
    get :edit, :id => listings(:macbook)
    assert_redirected_to new_user_session_path
  end
  
  test "update" do
    post :update, :id => listings(:macbook), :listing => {:title => 'Updated'}
    assert_response :redirect
    assert_redirected_to listing_path(listings(:macbook))
    listings(:macbook).reload
    assert_equal 'Updated', listings(:macbook).title
  end
  
  test "update when not signed in" do
    sign_out :user
    post :update, :id => listings(:macbook), :listing => {:title => 'Updated'}
    assert_redirected_to new_user_session_path
  end
  
end
