require 'spec_helper'

describe "listings/index" do
  before do
    @listing = Factory(:listing, :title => 'Used MacBook')
    assigns[:listings] = [@listing]
    render
  end
  
  it "should render a link to the listing" do
    response.should have_tag("a[href=?]", listing_path(@listing), 'Used MacBook')
  end
end