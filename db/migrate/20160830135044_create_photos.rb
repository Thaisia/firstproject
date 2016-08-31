class CreatePhotos < ActiveRecord::Migration
  def change

    create_table :photos do |t|
      t.text :photo_link
      t.integer :theme_id

      t.timestamps
    end
  end
end
