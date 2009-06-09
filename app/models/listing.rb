class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :bids
  
  validates_presence_of :title, :description
  validates_inclusion_of :duration, :in => [3, 5, 7]
  
  before_save :calculate_end_at
  
  attr_accessible :title, :description, :duration
  
  named_scope :active, lambda {{
    :conditions => ['listings.created_at <= :now AND listings.end_at >= :now', {:now => Time.zone.now}],
    :order => 'listings.end_at'
  }}
  
  def highest_bid
    bids.first(:order => 'bids.cents DESC')
  end
  
  def active?
    end_at > Time.zone.now
  end
  
private
  
  def calculate_end_at
    self.end_at ||= (created_at || Time.zone.now) + duration.days
  end
  
end
