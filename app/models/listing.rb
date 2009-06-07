class Listing < ActiveRecord::Base
  attr_accessible :title, :description

  belongs_to :user
  has_many :bids

  validates_presence_of :title, :description
  validates_inclusion_of :duration, :in => [3, 5, 7]
  
  before_save :calculate_end_at
  
  scope :recent, order('listings.created_at DESC')
  
  scope :active, lambda {
    recent.where(['listings.created_at <= :now AND listings.end_at >= :now', {:now => Time.zone.now}])
  }
  
  attr_protected :end_at
  
  def highest_bid
    bids.order('bids.amount DESC').first
  end
  
  def active?
    end_at > Time.zone.now
  end
  
private
  
  def calculate_end_at
    self.end_at = (created_at || Time.zone.now) + duration.days
  end
  
end
