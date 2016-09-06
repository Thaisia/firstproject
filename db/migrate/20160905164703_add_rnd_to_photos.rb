class AddRndToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :shuffle_num, :integer
  end
end
