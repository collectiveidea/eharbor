class BidObserver < ActiveRecord::Observer
  
  def after_create(bid)
    if previous_bid = bid.listing.bids.first(:order => 'bids.cents DESC', :offset => 1)
      BidMailer.deliver_outbid_notification(previous_bid)
    end
  end
  
end
