class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.text :tag_name
      t.timestamps
    end

    Tag.create :tag_name => 'canon'
    Tag.create :tag_name => 'sony'
    Tag.create :tag_name => 'parrots'
    Tag.create :tag_name => 'bokeh'
    Tag.create :tag_name => 'blackandwhite'
  end
end
