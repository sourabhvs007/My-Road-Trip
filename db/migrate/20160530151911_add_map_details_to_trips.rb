class AddMapDetailsToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :from_address, :text
    add_column :trips, :to_address, :text
  end
end
