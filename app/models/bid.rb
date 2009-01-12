class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  
  money :amount, :cents => 'cents'
end
