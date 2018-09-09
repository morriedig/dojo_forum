class Friendship < ApplicationRecord
  validates :friend_id, uniqueness: { scope: :user_id }
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def is_uniq?
    if Friendship.find_by(user_id: self.user_id, friend_id: self.friend_id) || Friendship.find_by(user_id: self.friend_id, friend_id: self.user_id)
      return false
    end
    return true
  end
  
end
