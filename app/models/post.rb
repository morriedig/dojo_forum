class Post < ApplicationRecord
  mount_uploader :image, PostUploader
  # serialize :post_category_ids
  default_scope {order( created_at: :asc )}
  scope :most_viewed, -> { order( viewed_num: :desc ) }
  scope :draft, -> { where( "post_state == 'draft'") }
  belongs_to :user, counter_cache: true
  has_many :replies, dependent: :destroy
  has_many :join_posts, dependent: :destroy
  has_many :post_categories, through: :join_posts
  has_many :collection_posts, dependent: :destroy
  # accepts_nested_attributes_for :post_categories

  # def categories_attributes=(category_attributes)
  #   category_attributes.values.each do |category_attribute|
  #     post_category = PostCategory.find_or_create_by(category_attribute)
  #     self.post_categories << post_category
  #   end
  # end

  def collected?(user_id)
    self.collection_posts.pluck(:user_id).include?(user_id) ? "取消收藏" : "收藏"
  end

  def latest_reply
    if self.replies.present?
      return self.replies.last.created_at.strftime("%Y-%m-%m")
    else
      return "-"
    end
  end

  def add_viewed
    self.viewed_num = self.viewed_num + 1
    self.save
  end
end
