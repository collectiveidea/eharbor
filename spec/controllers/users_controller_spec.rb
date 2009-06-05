require 'spec_helper'

describe UsersController do
  before do
    @user = Factory(:user)  
    @listing = Factory(:listing, :user => @user) 
  end

  describe "show" do
    before do 
      get :show, :id => @user
    end
    
    it "should succeed" do
      response.should be_success   
      response.should render_template("show")
    end                                        
  end 
  
  context "when signed in" do  
    before do
      sign_in_as @user
    end        
    
    describe "edit" do   
      before do                 
        get :edit, :id  => @user
      end     
      
      it "should succeed" do
        response.should be_success
        response.should render_template("edit")
      end
      
      it "should assign a user" do
        assigns[:user].should == @user
      end
    end    
    
    describe "update" do
      before do
        put :update, :id => @user, :user => {:email => "bob@example.com"}
      end
      
      it "should redirect to the user path" do
        response.should redirect_to(user_path(@user))
      end
    end
  end
                                   
end