#START:index
class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end
end
#END:index