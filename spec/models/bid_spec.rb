require 'spec_helper'

describe Bid do
  context "validations" do
    before do
      @listing = Factory(:listing)
      @bid = Factory.build(:bid, :listing => @listing, :amount => "$10.00")
    end
    it "should be valid" do
      @bid.should be_valid
    end

    it "should not be valid when lower than highest bid" do
      Factory(:bid, :listing => @listing, :amount => "$20.00")
      @bid.should_not be_valid
    end

    it "should not be valid when equal to highest bid" do
      Factory(:bid, :listing => @listing, :amount => "$10.00")
      @bid.should_not be_valid
    end

    it "should be valid when greater than highest bid" do
      Factory(:bid, :listing => @listing, :amount => "$5.00")
      @bid.should be_valid
    end
  end
end