class Reply < ApplicationRecord
  default_scope { order(id: :desc) }
  belongs_to :post, counter_cache: true
  belongs_to :user, counter_cache: true
end
