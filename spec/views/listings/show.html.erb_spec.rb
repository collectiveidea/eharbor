require 'spec_helper'

describe "listings/show" do
  before do
    @listing = Factory(:listing, :title => 'Used MacBook')
    assigns[:listing] = @listing
    render
  end
  
  it "should render a link to the listing" do
    response.should have_tag("h2", @listing.title)
  end
end