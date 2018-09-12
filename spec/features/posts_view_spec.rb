require 'rails_helper.rb'
 
feature "if user didn't login he can " do  

  scenario " view all publish post " do
    user = create(:user)
    posts = create_list(:post, 5, user: user, post_state: "publish")
    visit '/posts'
    posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  scenario " can't view all drafe post " do
    user = create(:user)
    posts = create_list(:post, 5, user: user, post_state: "draft")
    visit '/posts'
    posts.each do |post|
      expect(page).not_to have_content(post.title)
    end
  end
end