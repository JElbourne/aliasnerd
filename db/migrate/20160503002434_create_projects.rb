class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :web_link
      t.string :github_link

      t.timestamps null: false
    end
  end
end
