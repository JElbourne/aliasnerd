class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :web_link, null: false
      t.string :github_link, null: false
      t.string :slug, null: false

      t.timestamps null: false
    end
    add_index :projects, :slug, unique: true
  end
end
