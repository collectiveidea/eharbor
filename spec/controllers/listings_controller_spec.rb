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

  describe "new" do
    before do
      get :new
    end
    
    it "should render the new template" do
      response.should be_success
      response.should render_template('new')
    end
  
    it "should assign a new listing for the view" do
      assigns(:listing).should be_kind_of(Listing)
      assigns(:listing).should be_new_record
    end
  end  
  
  describe "create" do 
    def do_action
      @listing_attrs = Factory.attributes_for(:listing, :title => "Big Mac")
      post :create, :listing => @listing_attrs
    end
    
    it "should create a new listing" do
      method(:do_action).should change { Listing.count }.by(1)
    end
     
    it "should redirect to the listing" do
      do_action
      response.should redirect_to(listing_path(assigns[:listing]))
    end
  end

end