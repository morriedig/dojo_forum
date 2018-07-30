class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :collection_posts, dependent: :destroy
  has_many :love_posts, through: :collection_posts
  
  def admin?
    return self.role === "admin"
  end

  def collected?(post_id)
    self.collection_posts.pluck(:post_id).include?(post_id)
  end
end
