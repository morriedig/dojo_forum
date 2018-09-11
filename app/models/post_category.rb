class PostCategory < ApplicationRecord
  has_many :join_posts, dependent: :restrict_with_error
  has_many :posts, through: :join_posts
  default_scope { order(id: :asc) }
end
