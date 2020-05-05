class AddConversationIdToChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :conversation_id, :integer
  end
end
