class AddLanguageToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_column :chatrooms, :language, :string
  end
end
