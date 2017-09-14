class AddMangaTitlesToManga < ActiveRecord::Migration[5.1]
  def change
    add_reference :mangas, :manga_title, foreign_key: true
  end
end
