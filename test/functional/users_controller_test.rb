require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  context "not signed in" do
    context "show" do
      setup do
        get :show, :id => users(:brandon)
      end
    
      should_respond_with :success
      should_render_template 'show'
      should_assign_to(:user) { users(:brandon) }
    
      should "link to listings" do
        assert_select 'a[href=?]', listing_path(listings(:macbook))
      end
    
      should "not have link to edit profile" do
        assert_select 'a[href=?]', edit_profile_path, false
      end
    end
  end
  
  context "signed in" do
    setup do
      sign_in_as users(:brandon)
    end
    
    context "show" do
      setup do
        get :show, :id => users(:brandon)
      end
      
      should "not link to edit profile" do
        assert_select 'a[href=?]', edit_profile_path
      end
    end
    
    context "edit" do
      setup do
        get :edit, :id => users(:brandon)
      end
      
      should_respond_with :success
      should_render_template 'edit'
      should_assign_to(:user) { users(:brandon) }
    end
    
    context "update" do
      setup do
        put :update, :id => users(:brandon), :user => {:email => 'brandon@example.com'}
      end
      
      should_respond_with :redirect
      should_redirect_to('the user profile') { user_path(users(:brandon)) }
    end
  end
  
  
end
