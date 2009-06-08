class BidsController < ApplicationController
  before_filter :authenticate
  
  def create
    @listing = Listing.find(params[:listing_id])
    @bid = @listing.bids.build(params[:bid])
    @bid.user = current_user
    if @bid.save
      if previous_bid = @listing.bids.first(:order => 'bids.cents DESC', :offset => 1)
        BidMailer.deliver_outbid_notification(previous_bid)
      end
      redirect_to @listing
    else
      render :template => 'listings/show'
    end
  end
  
end
