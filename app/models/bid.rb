class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :user_id, :listing_id, :amount, :presence => true, :numericality => true
  validate :verify_minimum_bid
  validate :verify_active_listing
  
private

  def verify_minimum_bid
    if listing.highest_bid && amount && listing.highest_bid.amount >= amount
      errors.add :amount, 'must be more than highest bid.'
    end
  end
  
  def verify_active_listing
    errors.add :base, 'This listing has expired.' unless listing.active?
  end
  
end
