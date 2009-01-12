class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.integer :user_id
      t.integer :listing_id
      t.integer :cents

      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
