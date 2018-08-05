class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :collection_posts, dependent: :destroy
  has_many :love_posts, through: :collection_posts
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :reverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :reverse_friends, through: :reverse_friendships, source: :user

  def all_friends
    (friends + reverse_friends).uniq
  end

  def admin?
    return self.role === "admin"
  end

  def collected?(post_id)
    self.collection_posts.pluck(:post_id).include?(post_id)
  end

  def add_friend?(friend)
    self.friendships.pluck(:friend_id).include?(friend.id)
  end

  def added_friend?(friend)
    friend.friendships.pluck(:friend_id).include?(self.id)
  end

  def friend?(friend)
    # puts self.add_friend?(friend)
    puts "+++"
    if self.add_friend?(friend)
      friendship = self.friendships.find_by(friend_id: friend.id)
      puts friendship.friend_state
      case friendship.friend_state
      when "viewed"
        "已讀"
      when "friend"
        "移除好友"
      when "inviting"
        return "inviting"
      else
        "系統有誤，請通知管理員"
      end
    elsif self.added_friend?(friend)
      friendship = friend.friendships.find_by(friend_id: self.id)
      case friendship.friend_state
      when "friend"
        "移除好友"
      when "inviting" || "viewed"
        "請確認"
      else
        "系統有誤，請通知管理員"
      end
    else
      return "add friend"
    end
  end
end
