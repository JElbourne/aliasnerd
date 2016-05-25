class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :video_source_id, null: false
      t.string :slug, null: false
      t.integer :project_id

      t.timestamps null: false
    end
    add_index :videos, :slug, unique: true
    add_index :videos, :project_id
  end
end
