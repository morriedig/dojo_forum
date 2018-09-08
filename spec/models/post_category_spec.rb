require 'rails_helper'

RSpec.describe PostCategory, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  context "category " do
    it " can be created" do
      expect do
        create(:post_category)
      end.to change { PostCategory.count }.by(1)
    end

    it "can't be deleted if category has post" do
      user = create(:user)
      post = create(:post, user: user)
      post_category = create(:post_category)
      JoinPost.create(post: post, post_category: post_category )
      expect do 
        post_category.destroy
      end.to change { PostCategory.count }.by(0)
    end
  end
end
