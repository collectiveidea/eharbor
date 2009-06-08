require 'test_helper'

class BidsControllerTest < ActionController::TestCase
  
  context "not signed in" do
    context "create" do
      setup { post :create, :listing_id => Factory(:listing) }
      should_deny_access
    end
  end
  
  context "signed in" do
    setup do
      sign_in_as users(:brandon)
    end
    
    context "create" do
      setup do
        setup do
          @listing = Factory(:listing)
          post :create, :listing_id => @listing, :bid => {:amount => 20}
        end
        
        should_respond_with :redirect
        should_redirect_to('the listing') { @listing }
        should_change 'listings(:macbook).bids.count'
        should_change 'users(:macbook).bids.count'
      end
    end
  end
  
end
