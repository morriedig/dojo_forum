require 'rails_helper'

RSpec.describe Admins::PostCategoriesController, type: :controller do
  it "only admin can enter backend" do
    user = create(:user)
    sign_in user
    get :index
    expect(response).to have_http_status(302)
  end

  describe "admin can" do
    let(:admin){create(:user, role: "admin")}
    let(:post_category) { create(:post_category) }
    before { sign_in admin }

    it "create post_category" do
      expect do
        post :create, params: { post_category: attributes_for(:post_category)}
      end.to change { PostCategory.count }.by(1)
    end

    # it "edit post_category" do
    #   put :update, params: { id: post_category.id, post_category: { title: "new post_category" } }

    #   expect(assigns(:post).title).to eq "new post_category"
    # end

    it "delete post_category" do
      post_category = create(:post_category)
      expect do
        delete :destroy, params: { id: post_category.id }
      end.to change { PostCategory.count }.by(-1)
    end
  end

  describe "admin can't" do
    let(:admin){create(:user, role: "admin")}
    it "can't delete post_category if it has post" do
      post_category = create(:post_category)
      post = create(:post, user: admin )
      JoinPost.create(post_id: post.id, post_category_id: post_category.id)
      expect do
        delete :destroy, params: {id: post_category.id}
      end.to change { PostCategory.count }.by(0)
    end
  end
end
