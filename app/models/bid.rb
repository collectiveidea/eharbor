class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  
  money_column :amount
  
  validates_presence_of :user_id, :listing_id, :amount
  validate :verify_minimum_bid
  
private
  
  def verify_minimum_bid
    if listing.highest_bid && amount && listing.highest_bid.amount >= amount
      errors.add :amount, 'must be more than highest bid.'
    end
  end
  
end
