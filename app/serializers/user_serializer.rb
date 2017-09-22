class UserSerializer < ApplicationSerializer
  attributes :id, :email, :success_msg

  def success_msg
    return "Successfully created you! Time to give them dem HHH boiiizz"
  end

end