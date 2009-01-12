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
    sign_in_as users(:brandon)
    get :show, :id => listings(:macbook)
    assert_response :success
    assert_template 'show'
    assert_equal listings(:macbook), assigns(:listing)
    
    assert_select 'h2', listings(:macbook).title
    assert_select 'form[action=?]', listing_bids_path(listings(:macbook))
  end
  
  test "new" do
    sign_in_as users(:brandon)
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
  
  test "new when signed out" do
    get :new
    assert_redirected_to sign_in_path
  end
  
  test "create" do
    sign_in_as users(:brandon)
    assert_difference 'Listing.count' do
      post :create, :listing => {:title => 'Getting Testy', :description => "Lorem…"}
    end
    assert_response :redirect
    assert_redirected_to listing_path(assigns(:listing))
  end
  
  test "create when signed out" do
    assert_no_difference 'Listing.count' do
      post :create, :listing => {:title => 'Getting Testy', :description => "Lorem…"}
    end    
    assert_redirected_to sign_in_path
  end
  
  test "edit" do
    sign_in_as users(:brandon)
    get :edit, :id => listings(:macbook)
    assert_response :success
    assert_template 'edit'
    assert_equal listings(:macbook), assigns(:listing)
  end
  
  test "edit when signed out" do
    get :edit, :id => listings(:macbook)
    assert_redirected_to sign_in_path
  end
  
  test "update" do
    sign_in_as users(:brandon)
    post :update, :id => listings(:macbook), :listing => {:title => 'Updated'}
    assert_response :redirect
    assert_redirected_to listing_path(listings(:macbook))
    listings(:macbook).reload
    assert_equal 'Updated', listings(:macbook).title
  end
  
  test "update when signed out" do
    post :update, :id => listings(:macbook), :listing => {:title => 'Updated'}
    assert_redirected_to sign_in_path
  end
  
end
