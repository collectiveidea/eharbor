class ListingsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  
  def index
    @listings = Listing.active
  end
  
  def show
    @listing = Listing.find(params[:id])
    
    respond_to do |format|
      format.html
      format.js { render :partial => 'info' }
    end
  end
  
  def new
    @listing = Listing.new
  end
  
  def create
    @listing = current_user.listings.build(params[:listing])
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end
  
  def edit
    @listing = current_user.listings.find(params[:id])
  end
  
  def update
    @listing = current_user.listings.find(params[:id])
    if @listing.update_attributes params[:listing]
      redirect_to @listing
    else
      render :edit
    end
  end
  
end
