class MangaSerializer < ApplicationSerializer
  attributes :id, :episode, :manga_title_id
  has_many :manga_contents
end
