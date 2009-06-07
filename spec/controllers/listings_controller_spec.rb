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
  
  context "when signed in" do
    before do
      @user = Factory(:user)
      sign_in_as @user
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
        @listing_attrs = Factory.attributes_for(:listing, :title => "Big Mac", :duration => 3)
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
  
    describe "edit" do
      before do
        @listing = Factory(:listing, :user => @user)
        get :edit, :id => @listing
      end
  
      it "should render the edit template" do
        response.should render_template 'edit'
      end
  
      it "should assign the listing for the view" do
        assigns(:listing).should == @listing
      end   
    end
   
    describe "update" do  
      
      before do
        @listing = Factory(:listing, :title => "Big Mac", :user => @user) 
      end

      def do_action
        post :update, :id => @listing, :listing => {:title => "Whopper"}
      end
  
      it "should not create a new listing" do
        method(:do_action).should_not change { Listing.count }
      end
   
      it "should redirect to the listing" do
        do_action
        response.should redirect_to(listing_path(@listing))
      end
  
      it "should update the listing attributes" do 
        do_action
        @listing.reload
        @listing.title.should == "Whopper"
      end
    end
  end

  context "when signed out" do
    [:new, :create, :edit, :update].each do |action|
      describe action do
        it "should redirect to the sign in page" do
          get action
          response.should redirect_to(sign_in_path)
        end
      end
    end
  end
  
end