class AddLanguageToGifs < ActiveRecord::Migration[6.0]
  def change
    add_column :gifs, :language, :string
  end
end
