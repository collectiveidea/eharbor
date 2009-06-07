require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  
  context "index" do
    setup do
      get :index
    end
    
    should "render success" do
      assert_response :success
    end
    
    should "render the 'index' template" do
      assert_template 'index'
    end
    
    should "assign listings" do
      assert_not_nil assigns(:listings)
      assert assigns(:listings).include?(listings(:macbook))
    end
    
    should "link to listings" do
      assert_select 'a[href=?]', listing_path(listings(:macbook)), listings(:macbook).title
    end
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
  
  test "create" do
    assert_difference 'Listing.count' do
      post :create, :listing => {:title => 'Getting Testy', :description => "Lorem…"}
    end
    assert_response :redirect
    assert_redirected_to listing_path(assigns(:listing))
  end
  
  test "edit" do
    get :edit, :id => listings(:macbook)
    assert_response :success
    assert_template 'edit'
    assert_equal listings(:macbook), assigns(:listing)
  end
  
  test "update" do
    post :update, :id => listings(:macbook), :listing => {:title => 'Updated'}
    assert_response :redirect
    assert_redirected_to listing_path(listings(:macbook))
    listings(:macbook).reload
    assert_equal 'Updated', listings(:macbook).title
  end
  
end
