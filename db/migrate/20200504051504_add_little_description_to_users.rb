class AddLittleDescriptionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :little_description, :string
  end
end
