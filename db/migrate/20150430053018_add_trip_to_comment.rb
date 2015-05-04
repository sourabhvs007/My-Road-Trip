class AddTripToComment < ActiveRecord::Migration
  def change
  	add_reference :comments, :trip, index: true
    add_foreign_key :comments, :trips
  end
end
