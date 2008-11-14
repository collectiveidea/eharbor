class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end
  
  def show
    @listing = Listing.find(params[:id])
  end
  
  def new
    @listing = Listing.new
  end
  
  def create
    @listing = Listing.create(params[:listing])
    redirect_to @listing
  end
end
