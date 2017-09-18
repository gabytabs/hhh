class MangaTitleSerializer < ApplicationSerializer
  attributes :id, :title, :type, :genre
  has_many :mangas
end
