class BidObserver < ActiveRecord::Observer
  
  def after_create(bid)
    if previous_bid = bid.listing.bids.first(:order => 'bids.amount DESC', :offset => 1)
      BidMailer.outbid_notification(previous_bid).deliver
    end
    BidMailer.seller_notification(bid).deliver
  end
  
end
