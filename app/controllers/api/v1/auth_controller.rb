class Api::V1::AuthController < ApplicationController
  before_action :authenticate_user!, only: :logout

  def login
    success = false
    if params[:email] && params[:password]
      user = User.find_by_email(params[:email])
      success = user && user.valid_password?(params[:password])
    end

    if success
      render json: {
        message: "ok",
        auth_token: user.authentication_token
      }
    else
      render json: { message: "failed" }, status: 401
    end
  end

  def logout
    current_user.generate_authentication_token
    current_user.save!

    render json: { message: "ok" }
  end
end
