class Api::V1::UsersController < Api::V1::ApplicationController

  #Create an Admin
  def create
    user = User.new(user_params)
    if user.save
      render json: user,
    end
  end

  #Sign In Admin

  #Sign Out Admin

  private

  def user_params
    params.require(:user).permit(:email)
  end

end