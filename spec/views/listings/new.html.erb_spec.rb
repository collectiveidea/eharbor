require 'spec_helper'

describe "listings/new" do
  before do
    assigns[:listing] = Listing.new
    render
  end
  
  it "should render the new listing form" do
    response.should have_tag('form[action=?]', listings_path) do
      with_tag('input[type=text][name=?]', 'listing[title]')
      with_tag('label[for=?]', 'listing_title')
      with_tag('label[for=?]', 'listing_description')
      with_tag('textarea[name=?]', 'listing[description]')
      with_tag('input[type=submit]')
    end
  end
end