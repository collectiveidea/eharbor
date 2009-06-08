require 'spec_helper'

describe BidObserver do
  describe "after_create" do 
    before do
      ActionMailer::Base.deliveries = [ ]
    end
    it "should send an email if there is a previous bid" do
      bid1 = Factory(:bid)
      bid2 = Factory(:bid, :listing => bid1.listing)
      email = ActionMailer::Base.deliveries.detect{|e| e.to.include(bid1.user.email)}
    end
    it "should not send an email if it is the first bid" do
      bid = Factory(:bid)
      email = ActionMailer::Base.deliveries.detect{|e| e.to.include(bid.user.email)}
      email.should be_nil
    end
  end
end