class AddUserIdToGifs < ActiveRecord::Migration[6.0]
  def change
    add_column :gifs, :user_id, :integer
  end
end
