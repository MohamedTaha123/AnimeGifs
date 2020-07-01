class AddReposHashToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :repos_hash, :text
  end
end
