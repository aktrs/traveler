class AddRoomIdToEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :entries, :room_id, :integer
  end
end
