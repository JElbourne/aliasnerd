class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :video_source_id, null: false
      t.string :slug, null: false

      t.timestamps null: false
    end
    add_index :videos, :slug, unique: true
  end
end
