class Api::V1::ApplicationController < ActionController::API
  include Knock::Authenticable
  undef_method :current_user
end