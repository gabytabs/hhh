class ApplicationSerializer < ActiveModel::Serializer
  # To get access with the current Rails routes
  include Rails.application.routes.url_helpers
end