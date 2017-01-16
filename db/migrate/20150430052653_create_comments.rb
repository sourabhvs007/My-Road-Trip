class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :message
    end
  end
end
