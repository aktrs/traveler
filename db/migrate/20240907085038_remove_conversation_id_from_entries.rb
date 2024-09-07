class RemoveConversationIdFromEntries < ActiveRecord::Migration[7.1]
  def change
    remove_column :entries, :conversation_id, :integer, if_exists: true
  end
end
