class MangaTitle < ApplicationRecord
  belongs_to :user
  has_many :mangas, dependent: :destroy
end
