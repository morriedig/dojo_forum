class CreateJoinPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_posts do |t|
      t.references :post, foreign_key: true
      t.references :post_category, foreign_key: true

      t.timestamps
    end
  end
end
