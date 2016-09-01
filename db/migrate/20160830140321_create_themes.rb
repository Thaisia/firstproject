class CreateThemes < ActiveRecord::Migration
  def change

    create_table :themes do |t|
      t.text :theme_link
      t.integer :parent_id
      t.text :theme_name
      t.integer  :container

      t.timestamps
    end

    Theme.create :theme_link => 'persons',        :parent_id =>   0, :theme_name => 'Persons'
    Theme.create :theme_link => 'places',         :parent_id =>   0, :theme_name => 'Places'
    Theme.create :theme_link => 'events',         :parent_id =>   0, :theme_name => 'Events'
    Theme.create :theme_link => 'closeup',        :parent_id =>   0, :theme_name => 'Closeup'
    Theme.create :theme_link => 'kids',           :parent_id =>   1, :theme_name => 'Kids'
    Theme.create :theme_link => 'gentlemen',      :parent_id =>   1, :theme_name => 'Gentlemen'
    Theme.create :theme_link => 'ladies',         :parent_id => 	1, :theme_name => 'Ladies'
    Theme.create :theme_link => 'groupportrait',  :parent_id => 	1, :theme_name => 'Group portrait'
    Theme.create :theme_link => 'nature',         :parent_id => 	2, :theme_name => 'Nature'
    Theme.create :theme_link => 'countries',      :parent_id => 	2, :theme_name => 'Countries'
    Theme.create :theme_link => 'night',          :parent_id => 	2, :theme_name => 'Night'
    Theme.create :theme_link => 'publicevents',   :parent_id => 	3, :theme_name => 'Public events'
    Theme.create :theme_link => 'socialdancing',  :parent_id => 	3, :theme_name => 'Social dancing'
    Theme.create :theme_link => 'sport',          :parent_id => 	3, :theme_name => 'Sport'
    Theme.create :theme_link => 'conserts',       :parent_id => 	3, :theme_name => 'Concerts'
    Theme.create :theme_link => 'flora',          :parent_id => 	4, :theme_name => 'Flora'
    Theme.create :theme_link => 'fauna',          :parent_id => 	4, :theme_name => 'Fauna'
    Theme.create :theme_link => 'things',         :parent_id => 	4, :theme_name => 'Things'
    Theme.create :theme_link => 'casual',         :parent_id => 	8, :theme_name => 'Casual'
    Theme.create :theme_link => 'sensual',        :parent_id => 	8, :theme_name => 'Sensual'
    Theme.create :theme_link => 'fancy',          :parent_id => 	8, :theme_name => 'Fancy'
    Theme.create :theme_link => 'familyportrait', :parent_id => 	9, :theme_name => 'Family portrait'
    Theme.create :theme_link => 'lovestory',      :parent_id => 	9, :theme_name => 'Love story'
    Theme.create :theme_link => 'wedding',        :parent_id => 	9,  :theme_name => 'Wedding'
    Theme.create :theme_link => 'russia',         :parent_id => 	10, :theme_name => 'Russia'
    Theme.create :theme_link => 'china',          :parent_id => 	11, :theme_name => 'China'
    Theme.create :theme_link => 'italy',          :parent_id => 	11, :theme_name => 'Italy'
    Theme.create :theme_link => 'spain',          :parent_id => 	11, :theme_name => 'Spain'
    Theme.create :theme_link => 'turkey',         :parent_id => 	11, :theme_name => 'Turkey'
    Theme.create :theme_link => 'croatia',        :parent_id => 	11, :theme_name => 'Croatia'
    Theme.create :theme_link => 'czech',          :parent_id => 	11, :theme_name => 'Czech'
    Theme.create :theme_link => 'slovenia',       :parent_id => 	11, :theme_name => 'Slovenia'
    Theme.create :theme_link => 'somanyroads',    :parent_id => 	2,  :theme_name => 'So many roads'
    Theme.create :theme_link => 'everyday',       :parent_id => 	3,  :theme_name => 'Every day'

  end
end
