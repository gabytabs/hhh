class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(params.require(:user).permit(:email, :password))
    user.save
  end

end
