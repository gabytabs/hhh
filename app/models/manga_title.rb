class MangaTitle < ApplicationRecord
  belongs_to :user
  has_many :mangas
end
