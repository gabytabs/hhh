class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(params.require(:user).permit(:email, :password))
    if user.save
      render json: user, serializer: UserSerializer
    else
      head(:unauthorized_entity)
    end
  end

end
