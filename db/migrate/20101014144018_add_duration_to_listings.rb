class AddDurationToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :duration, :integer
    add_column :listings, :end_at, :datetime
  end

  def self.down
    remove_column :listings, :end_at
    remove_column :listings, :duration
  end
end
