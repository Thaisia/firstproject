class CreateThemes < ActiveRecord::Migration
  def change

    create_table :themes do |t|
      t.text :theme_link
      t.integer :parent_id
      t.text :theme_name

      t.timestamps
    end

    Theme.create :theme_link => 'persons', :parent_id => 0 , :theme_name => 'Persons'
    Theme.create :theme_link => 'places', :parent_id => 0 , :theme_name => 'Places'
    Theme.create :theme_link => 'events', :parent_id => 0 , :theme_name => 'Events'
    Theme.create :theme_link => 'closeup', :parent_id => 0 , :theme_name => 'Closeup'
    Theme.create :theme_link => 'kids', :parent_id => 1 , :theme_name => 'Kids'
    Theme.create :theme_link => 'gentlemen', :parent_id => 1 , :theme_name => 'Gentlemen'

  end
end
