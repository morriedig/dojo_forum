class PostCategory < ApplicationRecord
  has_many :join_posts
  has_many :posts, through: :join_posts
end
