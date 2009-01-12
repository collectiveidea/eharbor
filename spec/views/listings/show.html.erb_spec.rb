require 'spec_helper'

describe "listings/show" do
  before do
    @listing = Factory(:listing, :title => 'Used MacBook')
    assigns[:listing] = @listing
  end
     
  context "when signed out" do  
    before do
      render
    end
    
    it "should render a link to the listing" do
      response.should have_tag("h2", @listing.title)
    end  
  end  
  
  context "when signed in" do
    before do
      @user = Factory(:user)
      sign_in_as @user
      render
    end                     
    
    it "should render a form for bidding" do
      response.should have_tag("form[action=?]", listing_bids_path(@listing))
    end
  end
end