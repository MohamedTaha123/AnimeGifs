class AddAttachementToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :attachement, :string
  end
end
