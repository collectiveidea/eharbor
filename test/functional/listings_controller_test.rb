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
      post :create, :listing => {:title => 'Getting Testy', :description => "Lorem..."}
    end
    assert_response :redirect
    assert_redirected_to listing_path(assigns(:listing))
  end
  
end
