class AddLikedToUser < ActiveRecord::Migration
  def change
    add_column :users, :liked, :boolean, null: false, default: false
    add_index :users, :liked
  end
end
