class Post < ApplicationRecord
  mount_uploader :image, PostUploader
  attr_accessor :post_category_ids
  has_many :replies, counter_cache: true
  belongs_to :user
  has_many :join_posts
  has_many :post_categories, through: :join_posts
  # accepts_nested_attributes_for :post_categories

  # def categories_attributes=(category_attributes)
  #   category_attributes.values.each do |category_attribute|
  #     post_category = PostCategory.find_or_create_by(category_attribute)
  #     self.post_categories << post_category
  #   end
  # end
end
