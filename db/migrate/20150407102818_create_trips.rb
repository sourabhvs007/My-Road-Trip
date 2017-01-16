class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :title
      t.text :description
      t.text :content
      t.string :main_image

      t.timestamps null: false
    end
  end
end
