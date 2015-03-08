class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.references :friendship

      t.string :name
      t.string :location
      t.string :image_url
      t.string :bio

      t.timestamps
    end
  end
end
