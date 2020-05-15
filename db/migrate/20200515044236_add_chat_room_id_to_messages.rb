class AddChatRoomIdToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :chatroom_id, :integer
  end
end
