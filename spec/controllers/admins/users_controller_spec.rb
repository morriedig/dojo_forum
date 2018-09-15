require 'rails_helper'

RSpec.describe Admins::UsersController, type: :controller do
  describe "admin can" do
    let(:admin){create(:user, role: "admin")}
    let(:user) { create(:user) }
    let(:admin2) { create(:user, role: "admin") }
    before { sign_in admin }
    
    it "chage user to role " do
      post :change_role, params: { id: user.id }
      expect(assigns(:user).role).to eq "admin"
    end

    it "chage user to guest " do
      post :change_role, params: { id: admin2.id }
      expect(assigns(:user).role).to eq "guset"
    end
  end
end
