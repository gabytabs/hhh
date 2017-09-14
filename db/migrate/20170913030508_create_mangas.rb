class CreateMangas < ActiveRecord::Migration[5.1]
  def change
    create_table :mangas do |t|
      t.string :url
      t.integer :episode

      t.timestamps
    end
  end
end
