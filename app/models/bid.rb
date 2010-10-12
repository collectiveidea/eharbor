class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  
  money_column :amount
end
