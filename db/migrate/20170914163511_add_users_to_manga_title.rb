class AddUsersToMangaTitle < ActiveRecord::Migration[5.1]
  def change
    add_reference :manga_titles, :user, foreign_key: true
  end
end
