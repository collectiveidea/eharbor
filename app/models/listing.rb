class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :bids
  
  validates_presence_of :title, :description
  
  def highest_bid
    bids.first(:order => 'bids.cents DESC')
  end
end
