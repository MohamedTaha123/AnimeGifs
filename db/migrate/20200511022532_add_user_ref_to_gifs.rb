class AddUserRefToGifs < ActiveRecord::Migration[6.0]
  def change
    add_reference :gifs, :user,  foreign_key: true
  end
end
