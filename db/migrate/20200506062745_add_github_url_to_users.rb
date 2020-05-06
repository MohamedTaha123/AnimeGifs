class AddGithubUrlToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :github_url, :string
  end
end
