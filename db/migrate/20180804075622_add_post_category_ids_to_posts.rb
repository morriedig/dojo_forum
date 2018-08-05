class AddPostCategoryIdsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_category_ids, :text
  end
end
