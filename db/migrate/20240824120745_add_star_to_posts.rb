class AddStarToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :star, :integer
  end
end
