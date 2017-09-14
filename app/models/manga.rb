class Manga < ApplicationRecord

  belongs_to :manga_title
  has_many :manga_contents
  accepts_nested_attributes_for :manga_contents, allow_destroy: true

end
