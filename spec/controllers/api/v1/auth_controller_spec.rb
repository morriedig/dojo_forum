require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  
  it " login with emali and passowed" do
    user = create(:user)
    post "login", params: { email: user.email, password: '12345678' }
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)).to eq({
      'message' => 'ok',
      'auth_token' => user.authentication_token
    })
  end

  it "logout succesfully" do
    user = create(:user)
    sign_in user
    token = user.generate_authentication_token
    post "logout", params: { auth_token: user.authentication_token }

    expect(response).to have_http_status(200)
    user.reload
    expect(user.authentication_token).not_to eq(token)
  end
end
