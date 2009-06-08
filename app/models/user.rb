class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :listings
  has_many :bids
  
  validates_presence_of :nickname
  validates_uniqueness_of :nickname, :case_sensitive => false
  
  attr_accessible :nickname, :time_zone
  
  def to_s
    nickname
  end
end
