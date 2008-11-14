class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end
  
  def show
    @listing = Listing.find(params[:id])
  end
end
