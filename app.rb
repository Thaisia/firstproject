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

get '/' do
  db = get_db
  @themes = db.execute 'select * from themes;'
  @main = db.execute 'select * from pho;'
	erb :main
end

get '/coaching' do
  if params["ajax"] == "1"
	  erb :coaching, :layout => false
  else
    erb :coaching
  end
end

get '/aboutme' do

  db = get_db
  @themes = db.execute 'select * from themes;'



  if params["ajax"] == "1"
    erb :aboutme, :layout => false
  else
    erb :aboutme
  end

end

get '/gallery/:url_part' do
    db = get_db

    @theme_id = db.execute 'select id from themes where theme_link=?', params[:url_part]
    theme_id = @theme_id[0]['id']

    @photos = db.execute 'select pic_link, theme_name from pho join themes on pho.theme_id = themes.id where themes.parent_id = ? or themes.parent_id in (select id from themes where parent_id=?);', theme_id, theme_id
    if params["ajax"] == "1"
      erb :gallery, :layout => false
    else
      erb :gallery
    end
end
