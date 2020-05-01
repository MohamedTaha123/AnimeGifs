class CreateGifs < ActiveRecord::Migration[6.0]
  def change
    create_table :gifs do |t|
      t.string :image
      t.string :description
      t.string :label

      t.timestamps
    end
  end
end
