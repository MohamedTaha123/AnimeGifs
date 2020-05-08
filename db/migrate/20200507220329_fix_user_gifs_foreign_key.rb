class FixUserGifsForeignKey < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "gifs", "users"
  end
end
