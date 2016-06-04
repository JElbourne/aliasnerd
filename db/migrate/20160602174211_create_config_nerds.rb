class CreateConfigNerds < ActiveRecord::Migration
  def change
    create_table :config_nerds do |t|
      t.string :video_ad_id
      t.string :video_temp_id
      t.string :video_stream_id
      t.boolean :live, null: false, default: false

      t.timestamps null: false
    end
  end
end
