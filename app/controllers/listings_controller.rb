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
    @listing = Listing.new(params[:listing])
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end
end
