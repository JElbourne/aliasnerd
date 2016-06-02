class CreateVoters < ActiveRecord::Migration
  def change
    create_table :voters do |t|
      t.string :voting_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :voters, :voting_id
  end
end
