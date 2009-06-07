require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  def setup
    @brandon = Factory(:user, :nickname => 'brandon')
    @macbook = Factory(:listing, :title => 'MacBook', :user => @brandon)
  end
  
  test "index" do
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:listings)
    assert assigns(:listings).include?(@macbook)
    
    assert_select 'a[href=?]', listing_path(@macbook), @macbook.title
  end
  
  test "show" do
    sign_in_as @brandon
    get :show, :id => @macbook
    assert_response :success
    assert_template 'show'
    assert_equal @macbook, assigns(:listing)
    
    assert_select 'h2', @macbook.title
    assert_select 'form[action=?]', listing_bids_path(@macbook)
  end
  
  test "new" do
    sign_in_as @brandon
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
    sign_in_as @brandon
    assert_difference 'Listing.count' do
      post :create, :listing => {:title => 'Getting Testy', :description => "Lorem…", :duration => 3}
    end
    assert_response :redirect
    assert_redirected_to listing_path(assigns(:listing))
  end
  
  test "create when signed out" do
    assert_no_difference 'Listing.count' do
      post :create, :listing => {:title => 'Getting Testy', :description => "Lorem…", :duration => 3}
    end    
    assert_redirected_to sign_in_path
  end
  
  test "edit" do
    sign_in_as @brandon
    get :edit, :id => @macbook
    assert_response :success
    assert_template 'edit'
    assert_equal @macbook, assigns(:listing)
  end
  
  test "edit when signed out" do
    get :edit, :id => @macbook
    assert_redirected_to sign_in_path
  end
  
  test "update" do
    sign_in_as @brandon
    post :update, :id => @macbook, :listing => {:title => 'Updated'}
    assert_response :redirect
    assert_redirected_to listing_path(@macbook)
    @macbook.reload
    assert_equal 'Updated', @macbook.title
  end
  
  test "update when signed out" do
    post :update, :id => @macbook, :listing => {:title => 'Updated'}
    assert_redirected_to sign_in_path
  end
  
end
