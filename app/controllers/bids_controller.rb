class BidsController < ApplicationController
  before_filter :authenticate
  
  def create
    @listing = Listing.find(params[:listing_id])
    @bid = @listing.bids.build(params[:bid])
    @bid.user = current_user
    if @bid.save
      redirect_to @listing
    else
      render :template => 'listings/show'
    end
  end
  
end
