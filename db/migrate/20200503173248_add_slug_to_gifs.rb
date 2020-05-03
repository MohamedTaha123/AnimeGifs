class AddSlugToGifs < ActiveRecord::Migration[6.0]
  def change
    add_column :gifs, :slug, :string
    add_index :gifs, :slug, unique: true
  end
end
