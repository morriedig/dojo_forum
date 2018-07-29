class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.text :image
      t.string :post_state
      t.integer :replies_count, default: 0
      t.references :user, foreign_key: true
      t.references :post_category, foreign_key: true


      t.timestamps
    end
  end
end
