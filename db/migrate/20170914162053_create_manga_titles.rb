class CreateMangaTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :manga_titles do |t|
      t.string :title
      t.string :manga_type
      t.string :genre

      t.timestamps
    end
  end
end
