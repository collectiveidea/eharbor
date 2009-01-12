class Listing < ActiveRecord::Base
  attr_accessible :title, :description

  validates_presence_of :title, :description
end
