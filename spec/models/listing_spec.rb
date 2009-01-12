require 'spec_helper'

describe Listing do
  describe "validations" do
    before do
      @listing = Factory(:listing)
    end
    it "should be valid" do
      @listing.should be_valid
    end
    
    it "should be invalid without a title" do
      @listing.title = nil
      @listing.should_not be_valid
    end

    it "should be invalid without a description" do
      @listing.description = nil
      @listing.should_not be_valid
    end
  end
end