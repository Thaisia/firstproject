#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "sqlite3"

def get_db
  db = SQLite3::Database.new "test.db"
  db.results_as_hash = true
  return db
end

before do
  db = get_db
  @main = db.execute 'select * from pho;'
  @faces = db.execute 'select pic_link, theme_name from pho join themes on pho.theme_id = themes.id where themes.parent_id = 1 or themes.parent_id in (select id from themes where parent_id=1);'
	@places = db.execute 'select pic_link, theme_name from pho join themes on pho.theme_id = themes.id where themes.parent_id = 2 or themes.parent_id in (select id from themes where parent_id=2);'
  @events = db.execute 'select pic_link, theme_name from pho join themes on pho.theme_id = themes.id where themes.parent_id = 3 or themes.parent_id in (select id from themes where parent_id=3);'
  @closeup = db.execute 'select pic_link, theme_name from pho join themes on pho.theme_id = themes.id where themes.parent_id = 4 or themes.parent_id in (select id from themes where parent_id=4);'

end

get '/' do
	erb :main
end

get '/faces' do
  if params["ajax"] == "1"
    erb :faces, :layout => false
  else
    erb :faces
  end
end

get '/places' do
	erb :places, :layout => false
end

get '/events' do
	erb :events, :layout => false
end

get '/closeup' do
	erb :closeup, :layout => false
end

get '/coaching' do
	erb :coaching, :layout => false
end

get '/aboutme' do
	erb :aboutme, :layout => false
end
