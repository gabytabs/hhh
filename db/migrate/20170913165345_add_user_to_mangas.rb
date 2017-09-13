class AddUserToMangas < ActiveRecord::Migration[5.1]
  def change
    add_reference :mangas, :user, foreign_key: true
  end
end
