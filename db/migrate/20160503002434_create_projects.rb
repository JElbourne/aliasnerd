class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :web_link, null: false
      t.string :github_link, null: false

      t.timestamps null: false
    end
  end
end
