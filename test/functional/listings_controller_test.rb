require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  
  context "index" do
    setup do
      get :index
    end
    
    should_respond_with :success
    should_render_template 'index'
    should_assign_to :listings
    
    should "link to listings" do
      assert_select 'a[href=?]', listing_path(listings(:macbook)), listings(:macbook).title
    end
  end
  
  context "show" do
    setup do
      get :show, :id => listings(:macbook)
    end
    
    should_respond_with :success
    should_render_template 'show'
    should_assign_to(:listing) { assigns(:listing) }
    
    should "should listing title" do
      assert_select 'h2', listings(:macbook).title
    end
  end
  
  context "new" do
    setup do
      get :new
    end
    
    should_respond_with :success
    should_render_template 'new'
    should_assign_to :listing
    should "render form" do
      assert_select 'form[action=?]', listings_path do
        assert_select 'input[type=text][name=?]', 'listing[title]'
        assert_select 'label[for=?]', 'listing_title'
        assert_select 'label[for=?]', 'listing_description'
        assert_select 'textarea[name=?]', 'listing[description]'
        assert_select 'input[type=submit]'
      end
    end
  end
  
  context "create" do
    setup do
      post :create, :listing => {:title => 'Getting Testy', :description => "Lorem…"}
    end
    
    should_change 'Listing.count'
    should_respond_with :redirect
    should_redirect_to('the listing') { listing_path(assigns(:listing)) }
  end
  
  context "edit" do
    setup do
      get :edit, :id => listings(:macbook)
    end
    
    should_respond_with :success
    should_render_template 'edit'
    should_assign_to(:listing) { listings(:macbook) }
  end
  
  context "update" do
    setup do
      post :update, :id => listings(:macbook), :listing => {:title => 'Updated'}
    end
    
    should_respond_with :redirect
    should_redirect_to('the listing') { listings(:macbook) }
    
    should "update the listing" do
      listings(:macbook).reload
      assert_equal 'Updated', listings(:macbook).title
    end
  end
  
end
