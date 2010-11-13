class BidsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @listing = Listing.find(params[:listing_id])
    @bid = @listing.bids.build(params[:bid])
    @bid.user = current_user
    if @bid.save
      respond_to do |format|
        format.html do
          flash[:notice] = 'Your bid saved successfully.'
          redirect_to @listing
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = 'Your bid has an error.'
          render 'listings/show'
        end
        format.js { render 'create_failed' }
      end
    end
  end
  
end
