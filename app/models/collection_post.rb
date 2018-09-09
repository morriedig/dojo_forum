class CollectionPost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def is_uniq?
    if CollectionPost.find_by(user_id: self.user_id, post_id: self.post_id)
      return false
    end
    return true
  end
  
end
