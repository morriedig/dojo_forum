class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :collection_posts, dependent: :destroy
  has_many :love_posts, through: :collection_posts, :source => "post"

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :reverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :reverse_friends, through: :reverse_friendships, source: :user

  # friend_state 有兩個 state -> inviting, friend
  # scope :friend, -> { where( "friend_state == 'draft'") }

  def admin?
    return self.role === "admin"
  end

  def collected?(post_id)
    self.collection_posts.pluck(:post_id).include?(post_id)
  end

  # 已分佈的文章
  def had_published_post
    self.posts.published
  end

  def all_friends
    (friends + reverse_friends).uniq
  end

  # 已成為好友
  def friended
    self.friends.where(friendships: { friend_state: "friend" }) + self.reverse_friends.where(friendships: { friend_state: "friend" })
  end
  # 等待對方回覆
  def waiting_response
    self.friends.where(friendships: { friend_state: "inviting" })
  end
  # 回覆對方
  def please_response
    self.reverse_friends.where(friendships: { friend_state: "inviting" })
  end

  def add_friend?(friend)
    self.friendships.pluck(:friend_id).include?(friend.id)
  end

  def added_friend?(friend)
    friend.friendships.pluck(:friend_id).include?(self.id)
  end

  def friend?(friend)
    # puts self.add_friend?(friend)
    if self.all_friends.include?(friend)
      # 如果 self 是在等待回應
      if self.waiting_response.include?(friend)
        puts "============================"
        return "取消邀請"
      elsif self.please_response.include?(friend)
        return "確認"
      elsif self.friended.include?(friend)
        return "移除好友"
      else
        return "你們的關係，太過複雜"
      end
    else
      # 如果還沒有成為朋友
      puts "why !!!!!!!!!"
      return "Add friend"
    end
  end

  # 更新 朋友關係
  def update_ship(friend)
    if self.all_friends.include?(friend)
      # 如果 self 是在等待回應
      if self.waiting_response.include?(friend)
        friend_ship = self.friendships.find_by( friend_id: friend.id )
        friend_ship.destroy
      elsif self.please_response.include?(friend)
        friend_ship = friend.friendships.find_by( friend_id: self.id )
        friend_shipfriend_state = "friend"
        friend_ship.save
      elsif self.friended.include?(friend)
        if self.friends.where(friendships: { friend_state: "friend" }).include?(friend)
          friend_ship = self.friendships.find_by( friend_id: friend.id )
          friend_ship.destroy
        else
          friend_ship = friend.friendships.find_by( friend_id: self.id )
          friend_ship.destroy
        end
      else
        return "你們的關係，太過複雜"
      end
    else
      # 如果還沒有成為朋友
      self.friendships.create(friend_id: friend.id , friend_state: "inviting")
      self.save
    end
  end
end
