class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :bids
  
  validates_presence_of :title, :description
  validates_inclusion_of :duration, :in => [3, 5, 7]
  
  def highest_bid
    bids.first(:order => 'bids.cents DESC')
  end
end
