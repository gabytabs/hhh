class MangaSerializer < ApplicationSerializer
  attributes :id, :episode
  has_many :manga_contents
end
