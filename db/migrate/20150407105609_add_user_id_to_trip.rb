class AddUserIdToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :user_id, :integer, references: :users
  end
end
