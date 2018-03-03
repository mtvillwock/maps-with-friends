class CreateFriendships < ActiveRecord::Migration[4.2]
  def change
    create_table :friendships do |t|
      t.references :user
      t.references :friend

      t.timestamps
    end
  end
end
