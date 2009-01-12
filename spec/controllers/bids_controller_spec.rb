require 'spec_helper'

describe BidsController do
  
  context "when not signed in" do
    [:create].each do |action|
      describe action do 
        it "should redirect to sign in path" do 
          post action, :listing => {:title => "awesome macbook"}
        end
      end
    end
  end
  
  context "when signed in" do 
    before do
      @user = Factory(:user)  
      @listing = Factory(:listing)
      
      sign_in_as @user
    end
    describe "create" do      
      def do_action
        post :create, :listing_id => @listing, :bid => {:amount => 20}
      end  
      
      it "should redirect to the listing path" do  
        do_action
        response.should redirect_to(listing_path(@listing)) 
      end                                                           
      
      it "should create a new bid" do
        method(:do_action).should change{Bid.count}.by(1)
      end                                              
    end
  end
 
end