require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  context "when user not login " do
    let(:user) { create(:user) }  
    let(:post) { create(:post,user: user ) }

    it "index page should get all posts" do
      get :index
      expect(assigns(:posts)).to eq [post]
    end

    it "can't get show page should" do
      get :show, params: { id: post }
      expect(assigns(:post)).to eq nil
    end
  end

  context "when user login user " do
    let(:user) { create(:user) }  
    let(:other_user) { create(:user) }
    before { sign_in user }

    it "can get show" do
      post = create(:post, user: other_user)
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq post
    end

    it "can create post" do
      expect do
        post :create, params: { post: attributes_for(:post), user: user }
      end.to change { Post.count }.by(1)
    end

    it " can edit post" do
      old_post = create(:post, user: user )
      put :update, params: { id: old_post.id,  post: { title: "this is update" } }
      expect(assigns(:post)).to eq old_post
    end

    it " can delete post" do
      old_post = create(:post, user: user)
      expect { delete :destroy, params: { id: old_post.id } }.to change { Post.count }.by(-1)
    end

    it "can't edit other people post" do
      old_post = create(:post, user: other_user )
      put :update, params: {id: old_post.id, post: { title: "this is update" } }
      expect(assigns(:post).title).not_to eq "this is update"
    end

    it "can't delete other people post" do
      old_post = create(:post, user: other_user )
      expect { delete :destroy, params: { id: old_post.id } }.to change { Post.count }.by(0)
    end

  end
end
