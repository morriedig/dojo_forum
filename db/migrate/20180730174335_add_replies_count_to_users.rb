class AddRepliesCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :replies_count, :integer, default: 0
  end
end
