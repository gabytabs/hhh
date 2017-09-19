class MangaTitleSerializer < ApplicationSerializer
  attributes :id, :title, :manga_type, :genre
  has_many :mangas
end
