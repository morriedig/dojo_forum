class RemoveCategoryIdFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :posts, :post_category, index: true
    remove_foreign_key :copies, :post_categories
    # remove_reference :posts, :post_category_id, foreign_key: true
  end
end
