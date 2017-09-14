class MangaSerializer < ApplicationSerializer
  attributes :id, :title, :episode, :user_id
  has_many :manga_contents
end
