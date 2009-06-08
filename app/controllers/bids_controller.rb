class BidsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @listing = Listing.find(params[:listing_id])
    @bid = @listing.bids.build(params[:bid])
    @bid.user = current_user
    if @bid.save
      if previous_bid = @listing.bids.first(:order => 'bids.amount DESC', :offset => 1)
        BidMailer.outbid_notification(previous_bid).deliver
      end
      redirect_to @listing
    else
      render 'listings/show'
    end
  end
  
end
