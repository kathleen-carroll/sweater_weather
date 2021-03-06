class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    elsif user
      render json: {errors: ["Bad credentials", "Incorrect password"]}, status: 400
    else
      render json: {errors: ["Bad credentials", "Email not registered with valid account"]}, status: 400
    end
  end
end
