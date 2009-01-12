class Listing < ActiveRecord::Base
  attr_accessible :title, :description

  belongs_to :user
  has_many :bids

  validates_presence_of :title, :description
  
  def highest_bid
    bids.order('bids.amount DESC').first
  end
end
