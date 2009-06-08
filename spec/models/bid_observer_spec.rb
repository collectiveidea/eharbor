require 'spec_helper'

describe BidObserver do
  describe "after_create" do 
    before do
      ActionMailer::Base.deliveries = [ ]
    end
    it "should send an email if there is a previous bid" do
      bid1 = Factory(:bid, :amount => 10)
      bid2 = Factory(:bid, :listing => bid1.listing, :amount => 11)
      email = ActionMailer::Base.deliveries.detect{|e| e.to.include?(bid1.user.email)}
    end
    
    it "should not send an email if it is the first bid" do
      bid = Factory(:bid)
      email = ActionMailer::Base.deliveries.detect{|e| e.to.include?  (bid.user.email)}
      email.should be_nil
    end
      
    it "after_create should send the seller an email" do
      bid = Factory(:bid, :amount => 10)
      email = ActionMailer::Base.deliveries.select{|e| e.to.include?(bid.listing.user.email) }
      email.should_not be_nil
    end
  end
end