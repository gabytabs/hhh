class MangaTitle < ApplicationRecord
  belongs_to :user
  has_many :mangas, dependent: :destroy

  #Validations
  validates_presence_of [:title, :manga_type, :genre]

end
