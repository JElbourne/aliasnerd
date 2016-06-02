class CreateConfigNerds < ActiveRecord::Migration
  def change
    create_table :config_nerds do |t|
      t.boolean :live, null: false, default: false

      t.timestamps null: false
    end
  end
end
