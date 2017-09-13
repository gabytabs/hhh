class Manga < ApplicationRecord

  belongs_to :user
  has_many :manga_contents

end
