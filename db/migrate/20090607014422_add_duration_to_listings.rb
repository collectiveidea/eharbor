class AddDurationToListings < ActiveRecord::Migration
  class Listing < ActiveRecord::Base
  end
  
  def self.up
    add_column :listings, :duration, :integer
    add_column :listings, :end_at, :datetime
    
    Listing.all.each do |listing|
      listing.update_attributes :duration => 3, :end_at => listing.created_at + 3.days
    end
  end

  def self.down
    remove_column :listings, :duration
    add_column :listings, :end_at
  end
end
