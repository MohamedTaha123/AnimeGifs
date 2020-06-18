class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :images_hash
      t.string :label
      t.string :description
      t.string :gif_id

      t.timestamps
    end
  end
end
