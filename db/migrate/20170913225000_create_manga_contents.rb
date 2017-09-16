class CreateMangaContents < ActiveRecord::Migration[5.1]
  def change
    create_table :manga_contents do |t|
      t.string :img_url
      t.integer :page_num

      t.timestamps
    end
  end
end
