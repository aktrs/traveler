class RemoveConversationIdFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :conversation_id, :integer
  end
end
