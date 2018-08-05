class RemovePostCategoryIdFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :posts, :post_categories
  end
end
