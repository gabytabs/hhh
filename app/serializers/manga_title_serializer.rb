class MangaTitleSerializer < ApplicationSerializer
  attributes :id, :title, :level, :genre
  has_many :mangas
end
