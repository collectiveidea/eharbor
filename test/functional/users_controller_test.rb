require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  context "not signed in" do
    context "show" do
      setup do
        @user = Factory(:user)
        @listing = Factory(:listing, :user => @user)
        get :show, :id => @user
      end
    
      should_respond_with :success
      should_render_template 'show'
      should_assign_to(:user) { @user }
    
      should "link to listings" do
        assert_select 'a[href=?]', listing_path(@listing)
      end
    
      should "not have link to edit profile" do
        assert_select 'a[href=?]', edit_profile_path, false
      end
    end
  end
  
  context "signed in" do
    setup do
      @user = Factory(:user)
      sign_in_as @user
    end
    
    context "show" do
      setup do
        get :show, :id => @user
      end
      
      should "not link to edit profile" do
        assert_select 'a[href=?]', edit_profile_path
      end
    end
    
    context "edit" do
      setup do
        get :edit, :id => @user
      end
      
      should_respond_with :success
      should_render_template 'edit'
      should_assign_to(:user) { @user }
    end
    
    context "update" do
      setup do
        put :update, :id => @user, :user => {:email => 'brandon@example.com'}
      end
      
      should_respond_with :redirect
      should_redirect_to('the user profile') { user_path(@user) }
    end
  end
  
  
end
