class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def own?(user)
    self.user_id == user.id
  end

  def self.size
    all.size
  end
end
