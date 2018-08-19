class AddViewedNumToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :viewed_num, :integer, :default => 0
  end
end
