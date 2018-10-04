class Post < ApplicationRecord
  mount_uploader :image, PostUploader
  # serialize :post_category_ids
  default_scope {order( id: :asc )}
  scope :draft, -> { where( :post_state => 'draft') }
  scope :published, -> { where( :post_state => 'publish') }
  scope :order_latest_reply, -> { published.joins(:replies).reorder('replies.created_at DESC') }
  scope :order_most_reply, -> { published.reorder(replies_count: :desc) }
  scope :order_most_viewed, -> { published.reorder( viewed_num: :desc ) }
  belongs_to :user, counter_cache: true
  has_many :replies, dependent: :destroy
  has_many :join_posts, dependent: :destroy
  has_many :post_categories, through: :join_posts
  has_many :collection_posts, dependent: :destroy
  has_many :loved_users, through: :collection_posts, source: :user
  
  # accepts_nested_attributes_for :post_categories

  # def categories_attributes=(category_attributes)
  #   category_attributes.values.each do |category_attribute|
  #     post_category = PostCategory.find_or_create_by(category_attribute)
  #     self.post_categories << post_category
  #   end
  # end

  def collected?(user)
    if user
      self.loved_users.include?(user) ? "取消收藏" : "收藏"
    end
  end

  def latest_reply
    self.replies.present? ? self.replies.first.created_at.strftime("%Y-%m-%d") : "尚無留言"
  end

  def add_viewed
    self.viewed_num = self.viewed_num + 1
    self.save
  end

end
