require "spec_helper"
describe ListingsController do
  context "index" do
    before do
      @listing = Factory(:listing)
      get :index
    end
    
    it "should render the index" do
      response.should be_success
      response.should render_template('index')
    end                      
    
    it "should assign the listings for the view" do
      assigns(:listings).should include(@listing)
    end
  end 
  
  describe "show" do
    before do
      @listing = Factory(:listing)
      get :show, :id => @listing
    end
    
    it "should render the show template" do
      response.should render_template 'show'
    end
    
    it "should assign the listing for the view" do
      assigns(:listing).should == @listing
    end
  end
end