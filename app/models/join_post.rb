class JoinPost < ApplicationRecord
  belongs_to :post
  belongs_to :post_category
end
