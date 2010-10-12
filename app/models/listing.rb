class Listing < ActiveRecord::Base
  attr_accessible :title, :description

  belongs_to :user

  validates_presence_of :title, :description
end
