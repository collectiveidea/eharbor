class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
end
