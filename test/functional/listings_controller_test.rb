require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  
  context "not signed in" do
    context "index" do
      setup do
        @listing = Factory(:listing)
        get :index
      end
      
      should_respond_with :success
      should_render_template 'index'
      should_assign_to :listings
      
      should "link to listings" do
        assert_select 'a[href=?]', listing_path(@listing), @listing.title
      end
    end
    
    context "show" do
      setup do
        @listing = Factory(:listing)
        get :show, :id => @listing
      end
      
      should_respond_with :success
      should_render_template 'show'
      should_assign_to(:listing) { assigns(:listing) }
      
      should "should listing title" do
        assert_select 'h2', @listing.title
      end
      
      should "not display bid form when" do
        assert_select 'form[action=?]', listing_bids_path(@listing), false
      end
    end
    
    context "new" do
      setup { get :new }
      should_deny_access
    end
    
    context "create" do
      setup { post :create }
      should_deny_access
    end
    
    context "edit" do
      setup { get :edit, :id => Factory(:listing) }
      should_deny_access
    end

    context "update" do
      setup { put :update, :id => Factory(:listing) }
      should_deny_access
    end
    
  end
  
  context "signed in as a user" do
    setup do
      @user = Factory(:user)
      sign_in_as @user
    end
    
    context "show" do
      setup do
        @listing = Factory(:listing)
        get :show, :id => @listing
      end
      
      should "display bid form" do
        assert_select 'form[action=?]', listing_bids_path(@listing)
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
        post :create, :listing => {:title => 'Getting Testy', :description => "Lorem…", :duration => 3}
      end
      
      should_change 'Listing.count'
      should_respond_with :redirect
      should_redirect_to('the listing') { listing_path(assigns(:listing)) }
    end
    
    context "edit" do
      setup do
        @listing = Factory(:listing, :user => @user)
        get :edit, :id => @listing
      end
      
      should_respond_with :success
      should_render_template 'edit'
      should_assign_to(:listing) { @listing }
    end
    
    context "update" do
      setup do
        @listing = Factory(:listing, :user => @user)
        post :update, :id => @listing, :listing => {:title => 'Updated'}
      end
      
      should_respond_with :redirect
      should_redirect_to('the listing') { @listing }
      
      should "update the listing" do
        @listing.reload
        assert_equal 'Updated', @listing.title
      end
    end
  end
  
end
