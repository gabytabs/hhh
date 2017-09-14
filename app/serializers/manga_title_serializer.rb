class MangaTitleSerializer < ApplicationSerializer
  attributes :id, :title, :level
  has_many :mangas
end
