class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash

      t.string :name
      t.string :location
      t.string :image_url
      t.string :bio

      t.timestamps
    end
  end
end
