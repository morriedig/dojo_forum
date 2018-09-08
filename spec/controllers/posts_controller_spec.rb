require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  describe "GET #index" do
    context "admin can " do
      let(:user){create(:user)}
      let(:admin){create(:user, role: "admin")}
      before { sign_in admin }
      it "delete any post" do
        post = create(:post, user: user)
        expect do 
          delete :destroy, params: { id: post.id }
        end.to change { Post.count }.by(-1)
      end
    end

    context "user" do
      let(:user){create(:user)}
      let(:author){create(:user)}
      before { sign_in user }

      it "can create post" do
        expect do
          post :create, params: { post: attributes_for(:post), user: user } 
        end.to change { Post.count }.by(1)
      end

      it "can edit self post" do
        old_post = create(:post, user: user)  
        put :update, params: { id: old_post.id, post: { title: "this is update" } }
        expect(assigns(:post).title).to eq "this is update"
      end

      it "can delete self post" do
        post = create(:post, user: user)
        expect do
          delete :destroy, params: { id: post.id }
        end.to change { Post.count }.by(-1)
      end

      it " can't edit other people's post" do
        old_post = create(:post, user: author)
        put :update, params: { id: old_post.id, post: { title: "this is update" } }
        expect(assigns(:post).title).not_to eq "this is update"
      end

      it "can't delete other people's post" do
        post = create(:post, user: author)
        expect do
          delete :destroy, params: { id: post.id }
        end.to change { Post.count }.by(0)
      end
    end
  end
end
