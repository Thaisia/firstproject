class CreateThemes < ActiveRecord::Migration
  def change

    create_table :themes do |t|
      t.text :theme_link
      t.integer :parent_id
      t.text :theme_name
      t.integer  :container

      t.timestamps
    end

    Theme.create :theme_link => 'persons', :parent_id =>   0, :theme_name => 'Persons', :container => 0
    Theme.create :theme_link => 'places', :parent_id =>   0, :theme_name => 'Places', :container => 0
    Theme.create :theme_link => 'events', :parent_id =>   0, :theme_name => 'Events', :container => 0
    Theme.create :theme_link => 'closeup', :parent_id =>   0, :theme_name => 'Closeup', :container => 0
    Theme.create :theme_link => 'kids', :parent_id =>   1, :theme_name => 'Kids', :container => 1
    Theme.create :theme_link => 'gentlemen', :parent_id =>   1, :theme_name => 'Gentlemen', :container => 1
    Theme.create :theme_link => 'ladies', :parent_id => 	1, :theme_name => 'Ladies', :container => 0
    Theme.create :theme_link => 'groupportrait', :parent_id => 	1, :theme_name => 'Group portrait', :container => 0
    Theme.create :theme_link => 'nature', :parent_id => 	2, :theme_name => 'Nature', :container => 1
    Theme.create :theme_link => 'countries', :parent_id => 	2, :theme_name => 'Countries', :container => 0
    Theme.create :theme_link => 'night', :parent_id => 	2, :theme_name => 'Night', :container => 1
    Theme.create :theme_link => 'publicevents', :parent_id => 	3, :theme_name => 'Public events', :container => 1
    Theme.create :theme_link => 'socialdancing', :parent_id => 	3, :theme_name => 'Social dancing', :container => 1
    Theme.create :theme_link => 'conserts', :parent_id => 	3, :theme_name => 'Concerts', :container => 1
    Theme.create :theme_link => 'flora', :parent_id => 	4, :theme_name => 'Flora', :container => 1
    Theme.create :theme_link => 'fauna', :parent_id => 	4, :theme_name => 'Fauna', :container => 1
    Theme.create :theme_link => 'things', :parent_id => 	4, :theme_name => 'Things', :container => 1
    Theme.create :theme_link => 'casual', :parent_id => 	8, :theme_name => 'Casual', :container => 1
    Theme.create :theme_link => 'sensual', :parent_id => 	8, :theme_name => 'Sensual', :container => 1
    Theme.create :theme_link => 'fancy', :parent_id => 	8, :theme_name => 'Fancy', :container => 1
    Theme.create :theme_link => 'familyportrait', :parent_id => 	9, :theme_name => 'Family portrait', :container => 1
    Theme.create :theme_link => 'lovestory', :parent_id => 	9, :theme_name => 'Love story', :container => 1
    Theme.create :theme_link => 'wedding', :parent_id => 	9,  :theme_name => 'Wedding', :container => 1
    Theme.create :theme_link => 'russia', :parent_id => 	10, :theme_name => 'Russia', :container => 1
    Theme.create :theme_link => 'china', :parent_id => 	11, :theme_name => 'China', :container => 1
    Theme.create :theme_link => 'italy', :parent_id => 	11, :theme_name => 'Italy', :container => 1
    Theme.create :theme_link => 'spain', :parent_id => 	11, :theme_name => 'Spain', :container => 1
    Theme.create :theme_link => 'turkey', :parent_id => 	11, :theme_name => 'Turkey', :container => 1
    Theme.create :theme_link => 'croatia', :parent_id => 	11, :theme_name => 'Croatia', :container => 1
    Theme.create :theme_link => 'czech', :parent_id => 	11, :theme_name => 'Czech', :container => 1
    Theme.create :theme_link => 'slovenia', :parent_id => 	11, :theme_name => 'Slovenia', :container => 1
    Theme.create :theme_link => 'somanyroads', :parent_id => 	2,  :theme_name => 'So many roads', :container => 1
    Theme.create :theme_link => 'everyday', :parent_id => 	3,  :theme_name => 'Every day', :container => 1

  end
end
