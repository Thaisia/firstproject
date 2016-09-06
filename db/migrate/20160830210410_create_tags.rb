class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.text :tag_name
      t.timestamps
    end

    Tag.create :tag_name => 'birds'
    Tag.create :tag_name => 'blackandwhite'
    Tag.create :tag_name => 'bokeh'
    Tag.create :tag_name => 'canon'
    Tag.create :tag_name => 'canon85_12'
    Tag.create :tag_name => 'landscape'
    Tag.create :tag_name => 'lingerie'
    Tag.create :tag_name => 'm42'
    Tag.create :tag_name => 'macro'
    Tag.create :tag_name => 'nude'
    Tag.create :tag_name => 'parrots'
    Tag.create :tag_name => 'sigma12-24'
    Tag.create :tag_name => 'sonynex6'
    Tag.create :tag_name => 'sea'
    Tag.create :tag_name => 'eyeslosed'
    Tag.create :tag_name => 'faces'
    Tag.create :tag_name => 'cats'
    Tag.create :tag_name => 'sky'
    Tag.create :tag_name => 'sunsetsunrize'
    Tag.create :tag_name => 'woods'
    Tag.create :tag_name => 'mountains'
    Tag.create :tag_name => 'streets'
    Tag.create :tag_name => 'emotions'
    Tag.create :tag_name => 'waterfalls'

  end
end
