class AuthController < ApplicationController
  def auth_token
    if session_user
      render json: session_user
    else
      render json: { errors: 'No User Logged In' }
    end
  end
end
