class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :user_id, :listing_id, :amount, :presence => true, :numericality => true
  validate :verify_minimum_bid

private

  def verify_minimum_bid
    if listing.highest_bid && amount && listing.highest_bid.amount >= amount
      errors.add :amount, 'must be more than highest bid.'
    end
  end
  
end
