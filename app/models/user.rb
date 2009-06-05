class User < ActiveRecord::Base
  include Clearance::User

  validates_presence_of :nickname
  validates_uniqueness_of :nickname, :case_sensitive => false
  
  attr_accessible :nickname
  
  def to_s
    nickname
  end
end
